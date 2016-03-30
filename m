Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59237 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930AbcC3IrI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 04:47:08 -0400
Subject: Re: at86rf212B 868Mhz
References: <CAPpUg6Mc_OcRtws_qqM9gcrWfDH+MpsLt8zm6Q9ODABHThOzKw@mail.gmail.com>
 <56F25FF6.4040500@osg.samsung.com>
 <CAPpUg6MyVaH4rVH4GJv8LKiyH0CM9UpKYCMkhPAzxX3EEWKzJg@mail.gmail.com>
 <20160324081950.GA4057@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FB9289.4010900@osg.samsung.com>
Date: Wed, 30 Mar 2016 10:47:05 +0200
MIME-Version: 1.0
In-Reply-To: <20160324081950.GA4057@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 24/03/16 09:19, Alexander Aring wrote:
> Hi,
>
> On Thu, Mar 24, 2016 at 09:04:43AM +0100, Baptiste Clenet wrote:
>> Thanks Stefan, Ok so my tests show that it doesn't work for the
>> moment. I may go on Kernel 4.3 if you made any changes on this.
>>
> please check if the registers for page 0 channel 0 are set correctly.
> You can dump the registers with:
>
> cat /sys/kernel/debug/regmap/spi32766.0/registers
>
> "spi32766.0" maybe different on your board.
>

Baptiste, have you been able to debug this further? Comparing the 
register content and see if they are correct?

regards
Stefan Schmidt
