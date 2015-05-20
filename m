Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34947 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106AbbETQjQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 May 2015 12:39:16 -0400
Message-ID: <555CB8B0.7060203@osg.samsung.com>
Date: Wed, 20 May 2015 18:39:12 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH atubs-fw 3/4] atusb/fw: Add build system support for adding
 a DFU suffix to the fw file
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org> <1432127894-4760-4-git-send-email-stefan@datenfreihafen.org> <20150520163125.GH10959@ws>
In-Reply-To: <20150520163125.GH10959@ws>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Werner Almesberger <werner@almesberger.net>, Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hello.

On 20/05/15 18:31, Werner Almesberger wrote:
> Stefan Schmidt wrote:
>> DFU files need to have a valid DFU suffix which provides information
>> about the USB vendor and product ID
> Aah, more bureaucracy ! :)
>
Yup. :)

Good one is this case though. The suffix add a little crc protection and 
having the ID to make sure we flash it to the right device also sounds 
good to me :)

>> +		dfu-suffix -a $(NAME).dfu -d 0x$(USB_BCD_VERSION) -p 0x$(USB_PRODUCT_ID) -v 0x$(USB_VENDOR_ID)
> Would be nice to keep wc -L <= 80, though.

ok, will change this tomorrow and resend. Going afk now.

regards
Stefan Schmidt
