Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37199 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbbBEQDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Feb 2015 11:03:35 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next v2] ieee802154: fix netns settings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150205091016.GC12279@omega>
Date: Thu, 5 Feb 2015 08:03:25 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <1DEA1346-A348-434E-90F3-80E9EDC7E181@holtmann.org>
References: <alex.aring@gmail.com> <1422457112-4377-1-git-send-email-nicolas.dichtel@6wind.com> <20150128203645.GB30188@omega> <20150205091016.GC12279@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org

Hi Alex,

>>> 6LoWPAN currently doesn't supports x-netns and works only in init_net.
>>> 
>>> With this patch, we ensure that:
>>> - the wpan interface cannot be moved to another netns;
>>> - the 6lowpan interface cannot be moved to another netns;
>>> - the wpan interface is in the same netns than the 6lowpan interface;
>>> - the 6lowpan interface is in init_net.
>>> 
>>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> 
>> Acked-by: Alexander Aring <alex.aring@gmail.com>
>> 
>> Marcel, can you please queue this for bluetooth-next?
>> 
> 
> ping.

I completely missed this one and it is not even showing up in my local archive. Care to resend it with your ack attached to it.

Regards

Marcel

