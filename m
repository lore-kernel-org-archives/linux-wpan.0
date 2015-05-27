Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53900 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbbE0IrI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 May 2015 04:47:08 -0400
Message-ID: <55658489.70604@osg.samsung.com>
Date: Wed, 27 May 2015 10:47:05 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] atusb: add support for at86rf230
References: <1432471383-5029-1-git-send-email-alex.aring@gmail.com> <20150527065454.GA712@omega>
In-Reply-To: <20150527065454.GA712@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 27/05/15 08:54, Alexander Aring wrote:
> Stefan,
>
> On Sun, May 24, 2015 at 02:43:03PM +0200, Alexander Aring wrote:
>> This patch adds support for the at86rf230 version check which is used
>> by the rzusb stick.
>>
> is it okay to apply this patch for mainline for now?
Yes, just send my reviewed-by for it. (You already want acked-by for 
this driver for me? I guess I wait until I send a patch to the 
maintainers file)

> Then it's only a
> question to make _better_ patches for the atusb firmware. Werner told me
> that I should remove the a lot of ifdefs or we landing in a ifdef hell
> which is like a well known IoT-OS and that's true. Was a dirty hack.

I have yet to look at the firmware patches but if Werner already 
suggested some changes they should be taken into account. Especially if 
this would let us to ifdef hell. :)

I was really happy to see the raven avr stick patches. This will extend 
the potential userbase for atusb and ieee802154 quite a bit. Thanks for 
working on this.

regards
Stefan Schmidt
