Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33239 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbFDLvw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 07:51:52 -0400
Received: by padj3 with SMTP id j3so28228382pad.0
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 04:51:51 -0700 (PDT)
Message-ID: <55703BBD.4010903@gmail.com>
Date: Thu, 04 Jun 2015 17:21:25 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-tools 0/2] Update cca mode and options output
References: <20150604092001.GA8027@probook-6560b>
In-Reply-To: <20150604092001.GA8027@probook-6560b>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>, linux-wpan@vger.kernel.org

Hi Christoffer Holmstedt,

On 06/04/2015 02:50 PM, Christoffer Holmstedt wrote:

> Earlier cca_modes and cca_opts were printed separately but these two patches
> now prints them together so cca_opts are only printed when the specified mode
>   is (3).
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

Do you think that cca_mode number is required overhear..?

What i mean is that:
	The cca mode number 1 indicates that its *energy above threshold*,
So what i feel is that printing the number is required.

May be Alex has to tell its preferred or not. I think we can remove the number.

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
> Christoffer Holmstedt (2):
>    info: add cca mode descriptive text to output
>    info: remove old cca options capabilities output
>
>   src/info.c | 99 +++++++++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 60 insertions(+), 39 deletions(-)
>

-- 
Varka Bhadram

