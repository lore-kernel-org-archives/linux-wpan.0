Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35220 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbFDHLY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:11:24 -0400
Received: by wgme6 with SMTP id e6so26188213wgm.2
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:11:23 -0700 (PDT)
Date: Thu, 4 Jun 2015 09:11:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] nl802154: export supported commands
Message-ID: <20150604071117.GC1232@omega>
References: <1433330514-18494-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433330514-18494-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, Jun 03, 2015 at 04:51:54PM +0530, Varka Bhadram wrote:
> This patch list the supported commands by the radios.
> Output format is like this.
> ...
> Supported commands:
> 	* new_interface
> 	* del_interface
> 	* set_channel
> 	* set_pan_id
> 	* set_short_addr
> 	* set_tx_power
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Applied thanks.

- Alex
