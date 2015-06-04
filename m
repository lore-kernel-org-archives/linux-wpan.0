Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33419 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbFDHJs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:09:48 -0400
Received: by wiwd19 with SMTP id d19so11374835wiw.0
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:09:47 -0700 (PDT)
Date: Thu, 4 Jun 2015 09:09:44 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] info: add frequency output to current channel
Message-ID: <20150604070940.GB1232@omega>
References: <20150603114722.GA7329@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150603114722.GA7329@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 03, 2015 at 01:47:27PM +0200, Christoffer Holmstedt wrote:
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
> Not much to say here but I realised that the formatting done by
> print_freq_handler() add extra whitespaces when not needed e.g. when used for
> the current_channel output. I'm thinking about refactoring print_freq_handler()
> to get_freq() and return the float which in the end will let the caller do the
> formatting.
> 
> As an example to this problem default channel of 13 for channel page 0 with the
> openlabs SPI board for RPi will print 2 whitespaces instead of one which would
> look better.
> 
> 	current_channel: 13,  2415 MHz
> 
> It's not a big deal but I've put it on my todo list.
> 

ok. Applied thanks.

- Alex
