Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35557 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcCXIT6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Mar 2016 04:19:58 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so226744553wml.0
        for <linux-wpan@vger.kernel.org>; Thu, 24 Mar 2016 01:19:57 -0700 (PDT)
Date: Thu, 24 Mar 2016 09:19:51 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf212B 868Mhz
Message-ID: <20160324081950.GA4057@omega>
References: <CAPpUg6Mc_OcRtws_qqM9gcrWfDH+MpsLt8zm6Q9ODABHThOzKw@mail.gmail.com>
 <56F25FF6.4040500@osg.samsung.com>
 <CAPpUg6MyVaH4rVH4GJv8LKiyH0CM9UpKYCMkhPAzxX3EEWKzJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6MyVaH4rVH4GJv8LKiyH0CM9UpKYCMkhPAzxX3EEWKzJg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

Hi,

On Thu, Mar 24, 2016 at 09:04:43AM +0100, Baptiste Clenet wrote:
> Thanks Stefan, Ok so my tests show that it doesn't work for the
> moment. I may go on Kernel 4.3 if you made any changes on this.
> 

please check if the registers for page 0 channel 0 are set correctly.
You can dump the registers with:

cat /sys/kernel/debug/regmap/spi32766.0/registers

"spi32766.0" maybe different on your board.

- Alex
