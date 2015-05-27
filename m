Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35183 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbE0Lqm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 07:46:42 -0400
Received: by wgme6 with SMTP id e6so7053845wgm.2
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 04:46:41 -0700 (PDT)
Date: Wed, 27 May 2015 13:46:38 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] atusb: add support for at86rf230
Message-ID: <20150527114635.GD712@omega>
References: <1432471383-5029-1-git-send-email-alex.aring@gmail.com>
 <5565838F.60107@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5565838F.60107@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Stefan,

On Wed, May 27, 2015 at 10:42:55AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 24/05/15 14:43, Alexander Aring wrote:
> >This patch adds support for the at86rf230 version check which is used
> >by the rzusb stick.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >Cc: Stefan Schmidt <stefan@osg.samsung.com>
> >---
> >  drivers/net/ieee802154/atusb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> >index 1e18774..5b6bb9a 100644
> >--- a/drivers/net/ieee802154/atusb.c
> >+++ b/drivers/net/ieee802154/atusb.c
> >@@ -515,7 +515,7 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
> >  			man_id_1, man_id_0);
> >  		goto fail;
> >  	}
> >-	if (part_num != 3) {
> >+	if (part_num != 3 && part_num != 2) {
> >  		dev_err(&usb_dev->dev,
> >  			"unexpected transceiver, part 0x%02x version 0x%02x\n",
> >  			part_num, version_num);
> 
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> 

is this patch okay, even when it's the same product id? Possible
"stronger" test would be to check if atusb then part_num != 3, if rzusb
then != 2. Or can we add support for this later?

- Alex
