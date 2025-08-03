<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class ResetPasswordNotification extends Notification
{
    public $token;
    public function __construct($token)
    {
        $this->token = $token;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        $frontendUrl = rtrim(config('app.frontend_url'), '/');
        $resetUrl = "{$frontendUrl}/auth/password/reset-password?token={$this->token}&email=" . urlencode($notifiable->email);

        return (new MailMessage)
            ->subject('Reset Password Akun Anda')
            ->greeting('Halo, ' . $notifiable->name)
            ->line('Kami menerima permintaan untuk mengatur ulang password akun Anda.')
            ->action('Reset Password', $resetUrl)
            ->line('Jika Anda tidak merasa melakukan permintaan ini, abaikan email ini.');
    }
}
