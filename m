Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:53837 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdIPHIN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 16 Sep 2017 03:08:13 -0400
Received: by mail-yw0-f177.google.com with SMTP id x131so2585942ywa.10
        for <linux-wpan@vger.kernel.org>; Sat, 16 Sep 2017 00:08:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fda61128-d27a-8b08-5a31-97e8a57677fe@osg.samsung.com>
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw> <fda61128-d27a-8b08-5a31-97e8a57677fe@osg.samsung.com>
From: StarNight <starnight@g.ncu.edu.tw>
Date: Sat, 16 Sep 2017 15:08:09 +0800
Message-ID: <CAC=mGzja5h1xq66au-CX92oARptFaFGjZcOH5KU0oujBfH4vvw@mail.gmail.com>
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, devicetree@vger.kernel.org

2017-09-15 20:26 GMT+08:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
> On 09/10/2017 11:30 AM, Jian-Hong Pan wrote:
>>
>> LoRa is an implementation of LPWPAN.
>> Chirp Spread Spectrum (CSS) modulation, which is used by LoRa has been
>> specified by IEEE 802.15.4a.
>> This driver implements IEEE 802.15.4 mac over LoRa physical layer not
>> LoRaWAN.
>
>
> Please see my architectural comments on how to fit in LoRa transceiver in my
> other mail. I have a very specific question on this driver and its use with
> the mac802154 subsystem though.
>
> I had a look at the first datasheet I could find for it
> (http://www.semtech.com/images/datasheet/sx1276_77_78_79.pdf) and stumbled
> over this sentence:
> "Standard GFSK, FSK, OOK, and GMSK modulation is also provided
> to allow compatibility with existing systems or standards such
> as wireless MBUS and IEEE 802.15.4g."
>
> Does this mean the transceiver can run in a mode where it would be
> compatible with an plain (no LoRA support) IEEE 802.15.4g transceiver on the
> same frequency band, subHGZ here?

It is the datasheet that I refer to when I write the driver.

This series of chips (Semtech SX1276/77/78/79) have two operating modes:
LoRa mode and FSK/OOK mode
Its registers may be in different meaning and usage with in different operating
mode.
The overall registers comparing list can be found at "Table 41 Registers
Summary" of the datasheet.

However, the operating frequency of the chip is an issue.
It shuold meet regional regulatory requirements.
The meeted frequency could be found in the series of chips.

> While we do not have support for the 15.4g extension (MTU size, etc) in our
> stack right now this would be a very interesting first test for the driver.
> If this would be the case.

According to the datasheat, the FIFO buffer size of this series of chips is:
- 256 bytes in LoRa mode (Chapter 4.1.2.3. LoRa Mode FIFO Data Buffer)
- 64 bytes in FSK/OOK mode (Chapter 4.2.10. FIFO)

> How did you test your driver so far? Making sure that the device gets
> detected and setup correctly I assume. Did you also do full transmission and
> receive tests with this transceiver and mac802154? If yes, was it the same
> hardware on both sides or different?

I use a Raspberry Pi as the board and Archlinux ARM as the OS.
I make two SX1278 transceivers as SPI slaves connect to the Raspberry Pi,
because the Raspberry Pi has two SPI chip selector addresses.

Then, prepare the Device Tree overlap and install it before modprobe the driver
as a module.
There wil be two wpan interfaces in the system and show them with "ip addr".
I refer to the shell script in the "Setup a 6LoWPAN test network" section of
http://wpan.cakelab.org/ to setup the wpan interfaces.

iwpan dev wpan${i} set pan_id $panid
ip link add link wpan${i} name lowpan${i} type lowpan
ip link set wpan${i} up
ip link set lowpan${i} up

Two lowpan interfaces will be added and brought up.
Use "ip addr" again and will see the IPv6 addresses of the lowpan interfaces.

I also use an echo server and a client written by myself in Python 3 to test the
UDP communication between the two interfaces.

console of server side:
server.py <listening IPv6 address> <listening port>

console of client side:
client.py <src IPv6 address> <dest IPv6 address> <dest port> <data string>

Client will send the data string to server.
Server will capitalize the recieved data string from the client and send back to
the client.
Client will receive the capitalized data string and print it out.

By the way, those could be found in the project on my GitHub:
https://github.com/starnight/LoRa

Jian-Hong Pan
