<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pesan Baru dari Form Kontak</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8fafc;
            margin: 0;
            padding: 0;
        }

        .container {
            background-color: #ffffff;
            max-width: 600px;
            margin: 30px auto;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #1d4ed8;
            font-size: 20px;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            color: #333333;
            line-height: 1.6;
            margin: 10px 0;
        }

        .label {
            font-weight: bold;
            color: #111827;
        }

        .footer {
            margin-top: 30px;
            font-size: 12px;
            color: #6b7280;
            text-align: center;
        }

        @media only screen and (max-width: 600px) {
            .container {
                margin: 16px;
                padding: 16px;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>📬 Pesan Baru dari Form Kontak</h2>

        <p><span class="label">👤 Nama:</span> {{ $data['name'] }}</p>
        <p><span class="label">📧 Email:</span> {{ $data['email'] }}</p>
        <p><span class="label">📝 Subjek:</span> {{ $data['subject'] }}</p>
        <p><span class="label">💬 Pesan:</span></p>
        <p>{{ $data['message'] }}</p>

        <div class="footer">
            Email ini dikirim otomatis dari sistem website <strong>Berkah Laris</strong>.
        </div>
    </div>
</body>

</html>