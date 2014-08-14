Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from blu004-omc4s22.hotmail.com ([65.55.111.161]:57315 "EHLO
	BLU004-OMC4S22.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751832AbaHNGt5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 14 Aug 2014 02:49:57 -0400
Message-ID: <BLU437-SMTP995AAA001DD048D561AB10F7E80@phx.gbl>
Date: Thu, 14 Aug 2014 08:49:52 +0200
From: Cristiano <cristiano_dealti@hotmail.com>
MIME-Version: 1.0
References: <BLU437-SMTP953B598AADB36D1E05A85AF7EB0@phx.gbl> <20140813204803.GC19527@omega> <BLU437-SMTP12A2EB954408C4FD54C241F7EB0@phx.gbl> <20140814004013.GA2127@omega>
In-Reply-To: <20140814004013.GA2127@omega>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [Linux-zigbee-devel] Old wiki updated but issues pinging fake
 nodes with relatively large payloads (> 93 octets)
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-zigbee-devel <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

Thanks,
     The merge conflicts were related to the 802.11 (WiFi) stack.

Maybe the issue is specific to the fakelb driver. I don't have any 
supported SPI radio at the moment.
I need to find one.

I have the avr raven kit which I used with Contiki and other stuff which 
is not supported.

Regards,
   Cristiano

On 08/14/2014 02:40 AM, Alexander Aring wrote:
> On Wed, Aug 13, 2014 at 11:42:46PM +0200, Cristiano wrote:
>> Thanks Alex,
>>    Yes the two commits:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=eb06481d69c60f6f9318e935053dce13fe3e8951
>> and
>> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=51263fffadee28c99152fb78a2d41e3d10c9b0b5
>>
>>
>> are in my kernel tree.
>>
> ok. Sorry, was just a try.
>
>> I merged the rpi kernel with net-next maybe one week ago, just before 3.16
>> was released.
>> Merging them was quite easy. I had three small conflicts, related to the
>> 802.11 stack.
>>
> Do you mean 802.11 or 802.15.4? :-)
>
>> I will try net-next on qemu.
>>
> ok.
>
>> What ARCH/platform are you compiling the kernel for?
>>
> I have two beaglebones white and each of them has a atben (at86rf231) via
> spi conntected.
>
> Another setup are two atusb sticks which I use in two qemu vm's.
>
> Additional I have some contiki nodes which laying in my room around.
> There I have the avr raven development kit and some Feuerwhere msp430
> nodes (I ported it to contiki, there is no mainline support for the
> Feuerwhere nodes).
>
> I never used the fakelb driver. Mhhh, I dropped this driver now and I
> will add a rework of this after doing the mac802154 like mac80211
> stuff.
>
> - Alex
>
>

