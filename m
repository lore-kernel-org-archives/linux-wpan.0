Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtp1.unipi.it ([131.114.21.19]:58884 "EHLO smtp.unipi.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752718AbaKGNWb (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 7 Nov 2014 08:22:31 -0500
Message-ID: <545CC793.4020607@iet.unipi.it>
Date: Fri, 07 Nov 2014 14:22:27 +0100
From: Carlo Vallati <carlo.vallati@iet.unipi.it>
MIME-Version: 1.0
Subject: Re: 6lowpan with external radio
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com> <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org> <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com> <20141106165425.GA32499@omega> <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com> <20141106170830.GB32499@omega> <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com> <20141106182403.GA2321@omega> <20141106193445.GD2321@omega>
In-Reply-To: <20141106193445.GD2321@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Henning Rogge <hrogge@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

On 11/06/2014 08:34 PM, Alexander Aring wrote:
> Hi Carlo,
>
> On Thu, Nov 06, 2014 at 07:24:03PM +0100, Alexander Aring wrote:
>> On Thu, Nov 06, 2014 at 06:55:11PM +0100, Carlo Vallati wrote:
>>> Hi,
>>> you can also take a look at this work in progress of mine [0] in which I'm
>>> implementing a driver for the Xbee s1 cards.
>>> The implementation is still a work in progress, so it has only the basic TX
>>> and RX operations and it includes the latest subsystem changes (at least
>>> the version included in the 3.16 kernel).
>>> The driver communicates with the Xbee s1 card using a serial protocol to
>>> receive/send raw data, while most of the 802.15.4 are implemented in
>>> hardware (for this reason its structure follows the fakehard.c driver).
>>>
>>
>> well, I removed now any HardMAC functionality because it never had any
>> functionality. For example [0].
>>
>> This was used by the fakehard driver but there was no real netlink
>> interface which used these calls. HardMAC driver is another topic for
>> the future.
>>
>
> this will not mean that I don't accept HardMAC drivers. I do now a
> rework of this branch which looks very similar like wireless/mac80211
> afterwards.

I really do understand that. Although I had some experience with 
mac80211 driver, it took me a while to understand the structure of the 
802154 driver. A rework is more than welcome!

>
> The HardMAC functionality should be look like wireless. This
> means a cfg802154 implementation inside driver layer. Also netdev
> allocation/registration etc.. is inside driver layer. cfg802154 is just
> a callback structure for the netlink 802.15.4 calls.
>
> Really the current mainline HardMAC functionality was in some broken
> state which never had any functionality.


Yes I understand. As the support for HardMAC will be defined and 
included again I'll align my work and then you can evaluate it for 
inclusion (in case you think can be of interest).

>
>
> I hope you are not too frustrated now. :-)

No problem, I needed to write the driver anyway to run some experiments :-)

>
> - Alex
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
