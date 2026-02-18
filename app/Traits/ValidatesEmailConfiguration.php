<?php

namespace App\Traits;

trait ValidatesEmailConfiguration
{
    /**
     * Check if email configuration is properly set
     *
     * @return bool
     */
    protected function isEmailConfigurationValid(): bool
    {
        $requiredFields = [
            'MAIL_HOST' => config('mail.mailers.smtp.host'),
            'MAIL_USERNAME' => config('mail.mailers.smtp.username'),
            'MAIL_PASSWORD' => config('mail.mailers.smtp.password'),
            'MAIL_FROM_ADDRESS' => config('mail.from.address'),
            'MAIL_FROM_NAME' => config('mail.from.name'),
        ];

        // Check if all required fields are filled
        foreach ($requiredFields as $field => $value) {
            if (empty($value)) {
                return false;
            }
        }

        return true;
    }
}

