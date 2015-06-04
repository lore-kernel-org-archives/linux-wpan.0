Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46472 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752282AbbFDMMG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 08:12:06 -0400
Date: Thu, 4 Jun 2015 14:12:02 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH wpan-tools 0/2] Update cca mode and options output
Message-ID: <20150604121202.GE3045@probook-6560b>
References: <20150604092001.GA8027@probook-6560b>
 <55703BBD.4010903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55703BBD.4010903@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 05:21:25PM +0530, Varka Bhadram wrote:
> Hi Christoffer Holmstedt,
> 
> On 06/04/2015 02:50 PM, Christoffer Holmstedt wrote:
> 
> >Earlier cca_modes and cca_opts were printed separately but these two patches
> >now prints them together so cca_opts are only printed when the specified mode
> >  is (3).
> >
> >Output for "current" mode (only one line is printed for each wpan):
> >	cca_mode: 1, energy above threshold.
> >	cca_mode: 2, carrier sense only.
> >	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'and').
> >	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'or').
> >	cca_mode: 3, carrier sense with energy above threshold (logical operator is unknown).
> >	cca_mode: 4, ALOHA.
> >	cca_mode: 5, UWB preamble sense based on the SHR of a frame.
> >	cca_mode: 6, UWB preamble sense based on the packet with the multiplexed preamble.
> 
> Do you think that cca_mode number is required overhear..?
> 
> What i mean is that:
> 	The cca mode number 1 indicates that its *energy above threshold*,
> So what i feel is that printing the number is required.
> 
> May be Alex has to tell its preferred or not. I think we can remove the number.
> 
...cut...
> -- 
> Varka Bhadram
> 

I was convinced before that I needed it there, but then I tried to make my
case and I ended up with the conclusion that the user don't need it. Only
scenario it is needed is when the user wants to change it and it that case the
number is listed in the capabilities section.

I will remove the number if no one objects.

-- 
Christoffer Holmstedt
