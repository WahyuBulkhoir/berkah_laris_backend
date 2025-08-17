<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Events\Verified;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Carbon;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email',
            'username' => 'required|string|unique:users,username',
            'nama' => 'required|string',
            'no_hp' => 'required|string',
            'alamat' => 'required|string',
            'password' => 'required|string|min:6|confirmed',
            'terms' => 'accepted',
        ], [
            'terms.accepted' => 'You must agree to the terms and conditions.'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::create([
            'email' => $request->email,
            'username' => $request->username,
            'name' => $request->nama,
            'no_hp' => $request->no_hp,
            'alamat' => $request->alamat,
            'password' => Hash::make($request->password),
            'role_id' => 2,
        ]);

        event(new Registered($user));
        $user->sendEmailVerificationNotification();

        return response()->json([
            'message' => 'Registrasi berhasil. Silakan cek email Anda untuk verifikasi.',
            'user' => $user
        ], 201);
    }

    public function verify(Request $request, $id, $hash)
    {
        $user = User::findOrFail($id);

        if (!hash_equals((string) $hash, sha1($user->getEmailForVerification()))) {
            return redirect()->away('http://localhost:3000/auth/verify-invalid');
        }

        if ($user->hasVerifiedEmail()) {
            return redirect()->away('http://localhost:3000/auth/verify-success');
        }

        $user->markEmailAsVerified();
        event(new Verified($user));

        return redirect()->away('http://localhost:3000/auth/verify-success');
    }


    public function resendVerification(Request $request)
    {
        if ($request->user()->hasVerifiedEmail()) {
            return response()->json(['message' => 'Email sudah diverifikasi.'], 200);
        }

        $request->user()->sendEmailVerificationNotification();

        return response()->json(['message' => 'Link verifikasi telah dikirim ulang ke email Anda.']);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::where('username', $request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => 'Invalid credentials'], 401);
        }

        if (in_array($user->role_id, [1, 3]) && !$user->email_verified_at) {
            $user->email_verified_at = now();
            $user->save();
        }

        $tokenName = match ($user->role_id) {
            1 => 'admin-token',
            2 => 'pelanggan-token',
            3 => 'teknisi-token',
            default => 'user-token',
        };

        $token = $user->createToken($tokenName)->plainTextToken;

        $role = match ($user->role_id) {
            1 => 'admin',
            2 => 'pelanggan',
            3 => 'teknisi',
            default => 'unknown',
        };

        return response()->json([
            'message' => 'Login successful',
            'user' => $user,
            'role' => $role,
            'token' => $token,
        ], 200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logout berhasil']);
    }
}
