<?php

namespace App\Listeners;

use App\Events\SendMail;
use App\Mail\SendCustomMessage;
use App\Mail\SendMailFromHtml;
use App\Models\EmailTemplate;
use App\Traits\ValidatesEmailConfiguration;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Facades\Mail;

class SendMailNotification
{
    use ValidatesEmailConfiguration;
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  \App\Events\SendMail  $event
     * @return void
     */
    public function handle(SendMail $event) {
        // Check if email configuration is properly set before attempting to send
        if (!$this->isEmailConfigurationValid()) {
            // Email configuration is not complete, skip sending and continue
            return;
        }

        $data = $event->mailData;
        $template = EmailTemplate::where('slug', 'custom_mail')->first();
        $template = $template->html;
        $variables = [
          'name' => $data['to']['name'],
          'to' => $data['to']['email'],
          'subject' => $data['subject'],
          'body' => $data['body'],
          'sender_name' => $data['sender_name']
        ];
        if (preg_match_all("/{(.*?)}/", $template, $m)) {
            foreach ($m[1] as $i => $varname) {
                $template = str_replace($m[0][$i], sprintf($variables[$m[1][$i]], $varname), $template);
            }
        }
        $messageData = ['html' => $template, 'subject' => $data['subject']];
        if(config('queue.enable')){
            Mail::to($variables['to'])->queue(new SendMailFromHtml($messageData));
        }else{
            Mail::to($variables['to'])->send(new SendMailFromHtml($messageData));
        }
    }
}
