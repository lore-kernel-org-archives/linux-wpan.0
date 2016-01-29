Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34520 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbcA2OPz (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 29 Jan 2016 09:15:55 -0500
Subject: Re: [RFC bluetooth-next] 6lowpan: move reciving handling to generic
References: <1453927574-5074-1-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56AB7411.3000700@osg.samsung.com>
Date: Fri, 29 Jan 2016 15:15:45 +0100
MIME-Version: 1.0
In-Reply-To: <1453927574-5074-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hello.

On 27/01/16 21:46, Alexander Aring wrote:
> This patch moves 6lowpan receive handling into 6lowpan generic. I
> introduced some callback ops to make some link-layer specific handling.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> Hi,
>
> this patch is a draft to talking about to move the receive handling
> and evaluation of 6LoWPAN dispatches into net/6lowpan instead that
> every 6lowpan specific link-layer implementation will do that on his
> own.
>
> I added some callbacks for receive handling, other solutions would
> be to add runtime decisions into net/6lowpan/rx.c by eval the
> interface type.
>
> Any comments are welcome. It's not perfect yet and it can be still
> improved at some places, if we really like to go that way.

The first questions that comes to mind is why rx only and not tx?
This would also allow the fragment handling to move into the generic 
part. I'm aware that bluetooth is not using it but other 6LoWPAN 
adaptation layers do and it part of the RFC4944.

regards
Stefan Schmidt
