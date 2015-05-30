Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33075 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbE3KaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 30 May 2015 06:30:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 0/5] fixes and cleanups for cc2520
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Date: Sat, 30 May 2015 12:29:49 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <FCDD0B93-505A-4555-BAA7-A2621329CBFF@holtmann.org>
References: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Brad Campbell <bradjc5@gmail.com>, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This series mainly related to tx power settings with or without
> CC2591 amplifier.
> 
> 
> Hi Brad Campbell,
> 	I added you in CC. Please test these changes with CC2591.
> 
> --
> Varka Bhadram
> 
> Varka Bhadram (5):
>  cc2520: fix in default tx power setting
>  cc2520: fix CC2591 handling
>  cc2520: add set transmit power setting support
>  cc2520: update initial transmit power value
>  cc2520: update current channel
> 
> drivers/net/ieee802154/cc2520.c |  124 +++++++++++++++++++++++++++++++++++----
> include/linux/spi/cc2520.h      |    1 -
> 2 files changed, 114 insertions(+), 11 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

