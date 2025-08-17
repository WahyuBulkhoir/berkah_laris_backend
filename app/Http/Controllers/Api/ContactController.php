<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use App\Mail\ContactFormMail;

class ContactController extends Controller
{
    public function submit(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
            'subject' => 'required|string',
            'message' => 'required|string',
        ]);

        $toEmail = 'bulwahyu8@gmail.com';

        Mail::to($toEmail)->send(new ContactFormMail($validated));

        return response()->json(['message' => 'Pesan berhasil dikirim.']);
    }
}
