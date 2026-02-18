<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (Schema::hasTable('ticket_favorites')) { return; }
        
        Schema::create('ticket_favorites', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedInteger('ticket_id'); // Changed to unsignedInteger to match tickets.id (INT UNSIGNED)
            $table->timestamps();

            // Unique constraint: a user can only favorite a ticket once
            $table->unique(['user_id', 'ticket_id']);
            
            // Foreign keys - matching the types from tickets and users tables
            // tickets.id is INT UNSIGNED (from increments()), users.id is BIGINT UNSIGNED (from id())
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('ticket_id')->references('id')->on('tickets')->onDelete('cascade');
            
            // Indexes for faster queries
            $table->index('user_id');
            $table->index('ticket_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ticket_favorites');
    }
};
