Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtp2.unipi.it ([131.114.21.21]:37078 "EHLO smtp.unipi.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750881AbaKFSJv (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 6 Nov 2014 13:09:51 -0500
Message-ID: <545BB96E.7090808@iet.unipi.it>
Date: Thu, 06 Nov 2014 19:09:50 +0100
From: Carlo Vallati <carlo.vallati@iet.unipi.it>
MIME-Version: 1.0
Subject: Re: 6lowpan with external radio
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com> <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org> <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com> <20141106165425.GA32499@omega> <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com> <20141106170830.GB32499@omega>
In-Reply-To: <20141106170830.GB32499@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,
you can also take a look at this work in progress of mine [0] in which
I'm implementing a driver for the Xbee s1 cards.
The implementation is still a work in progress, so it has only the basic
TX and RX operations and it includes the latest subsystem changes (at
least the version included in the 3.16 kernel).
The driver communicates with the Xbee s1 card using a serial protocol to
receive/send raw data, while most of the 802.15.4 are implemented in
hardware (for this reason its structure follows the fakehard.c driver).

Even if your radio it's not 802.15.4, maybe you can emulate/simulate
some of the operations and information needed by the upper layers.
Best,

Carlo

[0] https://github.com/warner83/linuxbee/

On 11/06/2014 06:08 PM, Alexander Aring wrote:
> Hi,
> 
> On Thu, Nov 06, 2014 at 06:00:49PM +0100, Henning Rogge wrote:
>> On Thu, Nov 6, 2014 at 5:54 PM, Alexander Aring <alex.aring@gmail.com> wrote:
>>> Hi,
>>>
>>> On Thu, Nov 06, 2014 at 05:33:51PM +0100, Henning Rogge wrote:
>>>> I had a look at the fakelb driver,
>>>>
>>>> if I understand it right it just "connect" the raw-frame side of
>>>> multiple 6lowpan interfaces with each other, right? So it might be
>>>> part of the solution...
>>>>
>>>> the other part should be similar to the tun.c driver... unfortunately
>>>> the tun driver got quite complex from what I can see.
>>>>
>>>
>>> do you use a 802.15.4 radio? Then maybe the serial driver is something
>>> like that what you searching for.
>>
>> No, its not a 802.15.4 radio... its mostly layer 1 and some "listen
>> before talk/ALOHA" media access. I can send it raw frames (with a few
>> header fields) and get everything the radio receives via serial port.
>>
>> A friend of mine suggested looking into 6lowpan instead of writing my
>> own fragmentation/IP-compression/... scheme. The radio is very slow,
>> so I need something efficient.
>>
> 
> don't know how you can run 6LoWPAN on it. There exist 802.15.4 6LoWPAN
> [0] and BTLE 6LoWPAN [1]. You need many L2 informations at 6LoWPAN level
> for exmaple running IPv6 compression mechanism.
> 
> - Alex
> 
> [0] https://tools.ietf.org/html/rfc4944 - also see 6282 and 6775
> [1] http://tools.ietf.org/html/draft-ietf-6lo-btle-03 (hope this is the newest one)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
-------------------------------------
Carlo Vallati, PhD
Post Doc Researcher
Computer Networking Group
Dipartimento di Ingegneria dell'Informazione
Università di Pisa
Via Diotisalvi 2, 56122 Pisa - Italy
Ph. : (+39) 050-2217.572 (direct) .599 (switch)
Fax : (+39) 050-2217.600
Skype: warner83
E-mail: carlo.vallati@iet.unipi.it
http://www.iet.unipi.it/c.vallati/

-----------------------------------------------
