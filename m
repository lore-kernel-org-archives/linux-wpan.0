Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36214 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbFDLCS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 07:02:18 -0400
Received: by wibdq8 with SMTP id dq8so120845451wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 04:02:17 -0700 (PDT)
Date: Thu, 4 Jun 2015 13:02:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 0/2] Update cca mode and options output
Message-ID: <20150604110214.GB24599@omega>
References: <20150604092001.GA8027@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150604092001.GA8027@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 11:20:06AM +0200, Christoffer Holmstedt wrote:
> Earlier cca_modes and cca_opts were printed separately but these two patches
> now prints them together so cca_opts are only printed when the specified mode
>  is (3).
> 
> Output for "current" mode (only one line is printed for each wpan):
> 	cca_mode: 1, energy above threshold.
> 	cca_mode: 2, carrier sense only.
> 	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'and').
> 	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'or').
> 	cca_mode: 3, carrier sense with energy above threshold (logical operator is unknown).
> 	cca_mode: 4, ALOHA.
> 	cca_mode: 5, UWB preamble sense based on the SHR of a frame.
> 	cca_mode: 6, UWB preamble sense based on the packet with the multiplexed preamble.
> 
> capabilities:
> 	...
> 	cca_modes:
> 		(1) energy above threshold
> 		(2) carrier sense only
> 		(3, cca_opt: 0) carrier sense with energy above threshold (logical operator is 'and')
> 		(3, cca_opt: 1) carrier sense with energy above threshold (logical operator is 'or')
> 
> 

Please check your mail settings, can you try to make some "In-reply-to"
behaviour when you send more than one patch?

- Alex
