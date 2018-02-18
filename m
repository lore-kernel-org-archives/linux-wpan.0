Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:33544 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeBRPu6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 18 Feb 2018 10:50:58 -0500
Received: by mail-it0-f42.google.com with SMTP id q4so1931392itc.0
        for <linux-wpan@vger.kernel.org>; Sun, 18 Feb 2018 07:50:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB_54W74JZ55ehr1ZY2QZJD=k97jz_V=b8x0hhpb0ciYjd04tA@mail.gmail.com>
References: <20180217184113.GA7717@picapica.im> <CAB_54W7WdNDYgKN4gADN-bTRDoDz_TjYw2Bq8-=CLgF_CON-9w@mail.gmail.com>
 <20180218152128.GA31698@picapica.im> <CAB_54W74JZ55ehr1ZY2QZJD=k97jz_V=b8x0hhpb0ciYjd04tA@mail.gmail.com>
From: Alexander Aring <alex.aring@gmail.com>
Date: Sun, 18 Feb 2018 10:50:57 -0500
Message-ID: <CAB_54W6YUYA8THF=QGxxQ0s1-9iagvAchs9KjQ+CjOhdYuQUmg@mail.gmail.com>
Subject: Re: issues with at86rf212b transceiver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-02-18 10:40 GMT-05:00 Alexander Aring <alex.aring@gmail.com>:
> Hi,
>
> 2018-02-18 10:21 GMT-05:00  <anton@picapica.im>:
>> On Sat, Feb 17, 2018 at 02:04:04PM -0500, Alexander Aring wrote:
>>> Hi,
>>>
>>> 2018-02-17 13:41 GMT-05:00  <anton@picapica.im>:
>>> > Hi
>>> >
>>> > I have a transceiver at86rf212b connected to Atmel's SAMA5D2-XULT devboard.
>>> > It runs kernel from Atmel, based on Linux release 4.9. Maybe it's not a latest one,
>>> > but I checked that there are no significant changes to at86rf230 driver since then.
>>> >
>>> > So I have some issues with transceiver and at86rf230 driver module.
>>> > Is this driver considered production-ready, was it tested with at86rf212b?
>>> >
>>>
>>> So far I know somebody already use the driver with an at86rf212b -
>>> there was patches related to that.
>>>
>>> What do you mean with "production-ready"? GPL gives you no warranty
>>> and we do it as "hobby"...
>>>
>>> According your problem, show me "cat /proc/interrupts" I will see if
>>> the interrupt is fired (more than one time), otherwise I see a board
>>> setup problem...
>>>
>>> - Alex
>>
>> Hi Alex,
>>
>> Of course I understand about no warranty, just asking. Quality of drivers
>> accepted into mainline kernely may vary, especially for rare hardware.
>> I am ready to cooperate and help with improving this driver.
>>
>> Btw, I've googled thread from this mailing list
>> https://www.spinics.net/lists/linux-wpan/msg02555.html
>> "ping6 doesn't use at86rf230 driver"
>> with somewhat similar issues, but it was spi driver's fault. Not sure if it's
>> the same reason here, any ideas?
>>
>
> no, I mean another patch...
>
> 7598968d6fdbe8960b941246cc6ebef725899c59
>
> Tested on AT86RF212B where the part is detected to be the expected part...
>
> it makes probing working and so far I know it was working.
>
>> Ok, so I've started one of the dev board, looks like 12 interrupts are fired,
>> then something breaks and seems no more frames are sent, as interrupts count
>> does not update and TX bytes value of wpan0 remains 352
>>
>> Interrupt line from /proc/interrupts should be this one:
>> 161:          0      GPIO 109 Level     spi32765.0
>>
>
> ok good.
>
>> at86rf230 spi32765.0: Detected at86rf212 chip version 3
>> at86rf230 spi32765.0: unexcept state change from 0x01 to 0x08. Actual state: 0x01
>>
>
> ....
>
>> at86rf230 spi32765.0: not supported irq 84 received
>>
>
> This messages confused me, it should not happen unless you
> reading/writing garbage on SPI bus.
> We only use IRQ TRX_END and we are sure that we only receive these
> IRQs by IRQ_MASK_MODE and IRQ_MASK.
>
> Check your wiring, make a lower spi clock (Maybe we should make the
> clock at the devicetree documentation lower).
>
> But... this messages should not happen unless something is broken.
>

You can try to read registers with debugfs and regmap entry... and
look if the registers are the same as hw_init in the driver... if not
something weird going on e.g. lossy connection, too high spi-clock,
magnetic field, moon position, etc.

- Alex
