Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:56269 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750708AbbKQOBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Nov 2015 09:01:31 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] ieee802154-atusb: Delete an unnecessary check before the function call "kfree_skb"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5649DE40.6030405@osg.samsung.com>
Date: Tue, 17 Nov 2015 15:01:28 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <FB4ECAF8-4F55-4F5C-AF13-D402BEE9CE74@holtmann.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <5649D2AE.60100@users.sourceforge.net> <5649DE40.6030405@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

Hi Stefan,

>> The kfree_skb() function tests whether its argument is NULL and then
>> returns immediately. Thus the test around the call is not needed.
>> 
>> This issue was detected by using the Coccinelle software.
>> 
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  drivers/net/ieee802154/atusb.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
>> index 199a94a..b1cd865 100644
>> --- a/drivers/net/ieee802154/atusb.c
>> +++ b/drivers/net/ieee802154/atusb.c
>> @@ -310,8 +310,7 @@ static void atusb_free_urbs(struct atusb *atusb)
>>  		urb = usb_get_from_anchor(&atusb->idle_urbs);
>>  		if (!urb)
>>  			break;
>> -		if (urb->context)
>> -			kfree_skb(urb->context);
>> +		kfree_skb(urb->context);
>>  		usb_free_urb(urb);
>>  	}
>>  }
> 
> Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

for some reason I am missing the original patch, can someone resend it please.

Regards

Marcel

