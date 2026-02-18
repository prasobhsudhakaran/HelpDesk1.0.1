<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendMailFromHtml extends Mailable
{
    use Queueable, SerializesModels;

    public $mailData;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($mailData) {
        $this->mailData = $mailData;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build() {
        $fromAddress = config('mail.from.address', 'noreply@example.com');
        $fromName = config('mail.from.name', 'HelpDesk');
        
        // Ensure we have a valid from address
        if (empty($fromAddress)) {
            $fromAddress = 'noreply@example.com';
        }
        
        return $this->from($fromAddress, $fromName)
                    ->html($this->mailData['html'])
                    ->subject($this->mailData['subject']);
    }
}
