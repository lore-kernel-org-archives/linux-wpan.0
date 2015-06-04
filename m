Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46445 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371AbbFDLYl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 07:24:41 -0400
Date: Thu, 4 Jun 2015 13:24:37 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH wpan-tools 0/2] Update cca mode and options output
Message-ID: <20150604112437.GC3045@probook-6560b>
References: <20150604092001.GA8027@probook-6560b>
 <20150604110214.GB24599@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150604110214.GB24599@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 01:02:15PM +0200, Alexander Aring wrote:
> On Thu, Jun 04, 2015 at 11:20:06AM +0200, Christoffer Holmstedt wrote:
> > Earlier cca_modes and cca_opts were printed separately but these two patches
> > now prints them together so cca_opts are only printed when the specified mode
> >  is (3).
> > 
> > Output for "current" mode (only one line is printed for each wpan):
> > 	cca_mode: 1, energy above threshold.
> > 	cca_mode: 2, carrier sense only.
> > 	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'and').
> > 	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'or').
> > 	cca_mode: 3, carrier sense with energy above threshold (logical operator is unknown).
> > 	cca_mode: 4, ALOHA.
> > 	cca_mode: 5, UWB preamble sense based on the SHR of a frame.
> > 	cca_mode: 6, UWB preamble sense based on the packet with the multiplexed preamble.
> > 
> > capabilities:
> > 	...
> > 	cca_modes:
> > 		(1) energy above threshold
> > 		(2) carrier sense only
> > 		(3, cca_opt: 0) carrier sense with energy above threshold (logical operator is 'and')
> > 		(3, cca_opt: 1) carrier sense with energy above threshold (logical operator is 'or')
> > 
> > 
> 
> Please check your mail settings, can you try to make some "In-reply-to"
> behaviour when you send more than one patch?
> 
> - Alex

Sure, I will try to fix that. I just sent three different emails with "mutt -H"
now but will configure git and use git send-email instead in the future I think
that will fix the "In-reply-to" problem.

-- 
Christoffer Holmstedt
