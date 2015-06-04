Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35712 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbFDHNn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:13:43 -0400
Received: by wiga1 with SMTP id a1so37633112wig.0
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:13:42 -0700 (PDT)
Date: Thu, 4 Jun 2015 09:13:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] nl802154: export supported commands
Message-ID: <20150604071339.GD1232@omega>
References: <1433330514-18494-1-git-send-email-varkab@cdac.in>
 <20150604071117.GC1232@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150604071117.GC1232@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Thu, Jun 04, 2015 at 09:11:17AM +0200, Alexander Aring wrote:
> On Wed, Jun 03, 2015 at 04:51:54PM +0530, Varka Bhadram wrote:
> > This patch list the supported commands by the radios.
> > Output format is like this.
> > ...
> > Supported commands:
> > 	* new_interface
> > 	* del_interface
> > 	* set_channel
> > 	* set_pan_id
> > 	* set_short_addr
> > 	* set_tx_power
> > 
> > Signed-off-by: Varka Bhadram <varkab@cdac.in>
> 
> Applied thanks.

grml, now this adds a new enum in the interface which we have not
mainline now yet. Please doing send patches fast for kernelspace support
of this command.

Thanks.

- Alex
