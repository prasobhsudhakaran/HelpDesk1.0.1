<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Print Ticket #{{ $ticket->uid }}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', 'Helvetica', sans-serif;
            font-size: 12pt;
            line-height: 1.5;
            color: #000;
            background: white;
            padding: 10mm;
            max-width: 210mm;
            margin: 0 auto;
        }

        /* Print Header */
        .print-header {
            border-bottom: 2px solid #000;
            padding-bottom: 10px;
            margin-bottom: 15px;
            text-align: center;
        }

        .ticket-id {
            font-size: 20pt;
            font-weight: bold;
            margin: 0 0 5px 0;
            color: #000;
        }

        .ticket-subject {
            font-size: 12pt;
            margin: 0 0 5px 0;
            color: #333;
        }

        .print-date {
            font-size: 9pt;
            color: #666;
        }

        /* Sections */
        .ticket-section {
            margin-bottom: 15px;
        }

        .section-title {
            font-size: 13pt;
            font-weight: bold;
            margin: 0 0 10px 0;
            padding-bottom: 5px;
            border-bottom: 1px solid #ccc;
            color: #000;
        }

        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dotted #ddd;
        }

        .info-label {
            font-weight: bold;
            color: #333;
            min-width: 120px;
        }

        .info-value {
            color: #000;
            text-align: right;
        }

        /* Content */
        .ticket-content {
            padding: 15px;
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #000;
            line-height: 1.8;
        }

        .ticket-content p {
            margin: 0 0 10px 0;
            color: #000;
        }

        .ticket-content ul,
        .ticket-content ol {
            margin: 10px 0;
            padding-left: 20px;
        }

        .ticket-content li {
            margin: 5px 0;
            color: #000;
        }

        .resolution-content {
            background: #f0f9f0;
            border-color: #4caf50;
        }

        /* Attachments */
        .attachments-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .attachment-item {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: #f9f9f9;
        }

        .attachment-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .attachment-info strong {
            color: #000;
        }

        .attachment-meta {
            font-size: 10pt;
            color: #666;
        }

        /* Tags */
        .tags-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .tag-item {
            display: inline-block;
            padding: 4px 12px;
            background: #e5e7eb;
            border: 1px solid #9ca3af;
            border-radius: 4px;
            font-size: 10pt;
        }

        /* Timeline */
        .timeline {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .timeline-item {
            padding: 12px;
            border-left: 3px solid #3b82f6;
            padding-left: 15px;
            background: #f9f9f9;
            border-radius: 4px;
        }

        .timeline-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .timeline-date {
            font-size: 10pt;
            color: #666;
            font-weight: normal;
        }

        .timeline-content {
            color: #000;
            line-height: 1.6;
            margin-top: 5px;
        }

        .timeline-content p {
            margin: 0 0 8px 0;
            color: #000;
        }

        .timeline-user {
            font-size: 10pt;
            color: #666;
            margin-top: 5px;
            font-style: italic;
        }

        /* Print Footer */
        .print-footer {
            margin-top: 30px;
            padding-top: 15px;
            border-top: 2px solid #000;
            text-align: center;
        }

        .footer-line {
            border-top: 1px solid #ccc;
            margin: 10px 0;
        }

        .footer-text {
            font-size: 10pt;
            color: #666;
            margin: 5px 0;
        }

        /* Print Media Queries */
        @media print {
            body {
                background: white !important;
                margin: 0 !important;
                padding: 8mm !important;
                max-width: 100% !important;
                box-shadow: none !important;
            }

            .print-header {
                padding-bottom: 8px !important;
                margin-bottom: 12px !important;
            }

            .ticket-section {
                page-break-inside: avoid;
                break-inside: avoid;
                margin-bottom: 12px !important;
            }

            .section-title {
                margin-bottom: 8px !important;
                padding-bottom: 4px !important;
            }

            .info-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            /* Prevent page breaks inside content areas */
            .ticket-content,
            .info-grid,
            .attachments-list {
                page-break-inside: avoid;
                break-inside: avoid;
            }

            /* Allow page breaks between sections */
            .ticket-section + .ticket-section {
                page-break-before: auto;
            }

            /* Keep header with first section */
            .print-header {
                page-break-after: avoid;
            }

            /* Prevent orphaned rows */
            .info-row {
                page-break-inside: avoid;
            }

            /* Timeline items can break but try to keep together */
            .timeline {
                page-break-inside: auto;
            }

            .timeline-item {
                page-break-inside: avoid;
                break-inside: avoid;
                margin-bottom: 10px;
            }

            /* Remove any background colors for print */
            .ticket-content,
            .attachment-item,
            .timeline-item {
                background: white !important;
                border: 1px solid #000 !important;
            }

            /* Ensure text is black */
            * {
                color: #000 !important;
            }

            @page {
                margin: 8mm;
                size: A4;
            }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }

            .info-row {
                flex-direction: column;
                gap: 5px;
            }

            .info-value {
                text-align: left;
            }
        }
    </style>
</head>
<body>
    <!-- Print Header -->
    <div class="print-header">
        <h1 class="ticket-id">Ticket #{{ $ticket->uid }}</h1>
        <p class="ticket-subject">{{ $ticket->subject }}</p>
        <div class="print-date">Printed on: {{ now()->format('F d, Y \a\t g:i A') }}</div>
    </div>

    <!-- Ticket Information Section -->
    <div class="ticket-section">
        <h2 class="section-title">Ticket Information</h2>
        
        <div class="info-grid">
            <div class="info-row">
                <span class="info-label">Status:</span>
                <span class="info-value">{{ $ticket->status ? $ticket->status->name : 'N/A' }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Priority:</span>
                <span class="info-value">{{ $ticket->priority ? $ticket->priority->name : 'N/A' }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Customer:</span>
                <span class="info-value">{{ $ticket->user ? $ticket->user->name : 'N/A' }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Assigned to:</span>
                <span class="info-value">{{ $ticket->assignedTo ? $ticket->assignedTo->first_name . ' ' . $ticket->assignedTo->last_name : 'Unassigned' }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Department:</span>
                <span class="info-value">{{ $ticket->department ? $ticket->department->name : 'N/A' }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Category:</span>
                <span class="info-value">{{ $ticket->category ? $ticket->category->name : 'N/A' }}</span>
            </div>
            @if($ticket->subCategory)
            <div class="info-row">
                <span class="info-label">Sub Category:</span>
                <span class="info-value">{{ $ticket->subCategory->name }}</span>
            </div>
            @endif
            <div class="info-row">
                <span class="info-label">Type:</span>
                <span class="info-value">{{ $ticket->ticketType ? $ticket->ticketType->name : 'N/A' }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Source:</span>
                <span class="info-value">{{ ucfirst($ticket->source ?: 'Web') }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Created:</span>
                <span class="info-value">{{ $ticket->created_at->format('F d, Y \a\t g:i A') }}</span>
            </div>
            @if($ticket->due_date)
            <div class="info-row">
                <span class="info-label">Due Date:</span>
                <span class="info-value">{{ $ticket->due_date->format('F d, Y \a\t g:i A') }}</span>
            </div>
            @endif
            <div class="info-row">
                <span class="info-label">Last Updated:</span>
                <span class="info-value">{{ $ticket->updated_at->format('F d, Y \a\t g:i A') }}</span>
            </div>
            @if($ticket->impact_level)
            <div class="info-row">
                <span class="info-label">Impact Level:</span>
                <span class="info-value">{{ ucfirst($ticket->impact_level) }}</span>
            </div>
            @endif
            @if($ticket->urgency_level)
            <div class="info-row">
                <span class="info-label">Urgency Level:</span>
                <span class="info-value">{{ ucfirst($ticket->urgency_level) }}</span>
            </div>
            @endif
            @if($ticket->estimated_hours || $ticket->actual_hours)
            <div class="info-row">
                <span class="info-label">Time Tracking:</span>
                <span class="info-value">
                    @if($ticket->estimated_hours)
                        Estimated: {{ $ticket->estimated_hours }}h
                    @endif
                    @if($ticket->estimated_hours && $ticket->actual_hours)
                         | 
                    @endif
                    @if($ticket->actual_hours)
                        Actual: {{ $ticket->actual_hours }}h
                    @endif
                </span>
            </div>
            @endif
        </div>
    </div>

    <!-- Description Section -->
    <div class="ticket-section">
        <h2 class="section-title">Description</h2>
        <div class="ticket-content">{!! $ticket->details !!}</div>
    </div>

    <!-- Resolution Section -->
    @if($ticket->resolution)
    <div class="ticket-section">
        <h2 class="section-title">Resolution</h2>
        <div class="ticket-content resolution-content">{!! $ticket->resolution !!}</div>
    </div>
    @endif

    <!-- Attachments Section -->
    @if($attachments && $attachments->count() > 0)
    <div class="ticket-section">
        <h2 class="section-title">Attachments ({{ $attachments->count() }})</h2>
        <div class="attachments-list">
            @foreach($attachments as $file)
            <div class="attachment-item">
                <div class="attachment-info">
                    <strong>{{ $file->name }}</strong>
                    <span class="attachment-meta">
                        @php
                            $size = $file->size ?? 0;
                            $units = ['B', 'KB', 'MB', 'GB', 'TB'];
                            $i = $size > 0 ? floor(log($size, 1024)) : 0;
                            $formattedSize = $size > 0 ? round($size / pow(1024, $i), 2) . ' ' . $units[$i] : 'N/A';
                        @endphp
                        {{ $formattedSize }} • {{ $file->created_at->format('M d, Y') }}
                        @if($file->user)
                         • by {{ $file->user->first_name }} {{ $file->user->last_name }}
                        @endif
                    </span>
                </div>
            </div>
            @endforeach
        </div>
    </div>
    @endif

    <!-- Tags Section -->
    @if($ticket->tags && count($ticket->tags) > 0)
    <div class="ticket-section">
        <h2 class="section-title">Tags</h2>
        <div class="tags-list">
            @foreach($ticket->tags as $tag)
            <span class="tag-item">{{ $tag }}</span>
            @endforeach
        </div>
    </div>
    @endif

    <!-- Comments/Activity Timeline -->
    @if($comments && $comments->count() > 0)
    <div class="ticket-section">
        <h2 class="section-title">Comments ({{ $comments->count() }})</h2>
        <div class="timeline">
            @foreach($comments as $comment)
            <div class="timeline-item">
                <div class="timeline-header">
                    <strong>{{ $comment->user ? $comment->user->first_name . ' ' . $comment->user->last_name : 'System' }}</strong>
                    <span class="timeline-date">{{ $comment->created_at->format('M d, Y \a\t g:i A') }}</span>
                </div>
                <div class="timeline-content">{!! $comment->comment !!}</div>
            </div>
            @endforeach
        </div>
    </div>
    @endif

    <!-- Activities Section -->
    @if($activities && $activities->count() > 0)
    <div class="ticket-section">
        <h2 class="section-title">Activity Log</h2>
        <div class="timeline">
            @foreach($activities as $activity)
            <div class="timeline-item">
                <div class="timeline-header">
                    <strong>{{ $activity->action }}</strong>
                    <span class="timeline-date">{{ $activity->created_at->format('M d, Y \a\t g:i A') }}</span>
                </div>
                @if($activity->description)
                <div class="timeline-content">{{ $activity->description }}</div>
                @endif
                @if($activity->user)
                <div class="timeline-user">by {{ $activity->user->first_name }} {{ $activity->user->last_name }}</div>
                @endif
            </div>
            @endforeach
        </div>
    </div>
    @endif

    <!-- Print Footer -->
    <div class="print-footer">
        <div class="footer-line"></div>
        <p class="footer-text">Ticket #{{ $ticket->uid }} - {{ $ticket->subject }}</p>
        <p class="footer-text">Printed on {{ now()->format('F d, Y \a\t g:i A') }}</p>
    </div>

    <script>
        // Auto-print when page loads
        window.onload = function() {
            setTimeout(function() {
                window.print();
            }, 250);
        };
    </script>
</body>
</html>

