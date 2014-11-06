Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtp1.unipi.it ([131.114.21.19]:45695 "EHLO smtp.unipi.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750970AbaKFSNp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 6 Nov 2014 13:13:45 -0500
Message-ID: <545BBA58.8040703@iet.unipi.it>
Date: Thu, 06 Nov 2014 19:13:44 +0100
From: Carlo Vallati <carlo.vallati@iet.unipi.it>
MIME-Version: 1.0
Subject: Re: 6lowpan with external radio
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com> <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org> <CAGnRvuqOcBoDfh899hwB56Hizex7i3q1OasaFJbDBckYiwwPag@mail.gmail.com> <20141106165425.GA32499@omega> <CAGnRvupKzAbVpdokD3ix9fex0ZaTMtDH9dGZJpKWY2iyjw8_9A@mail.gmail.com> <20141106170830.GB32499@omega> <CAP0sMCzn-cRSDi7GoeLPFKH868vdW+DJsC_ak-eZwT+GEbwwiA@mail.gmail.com> <CAGnRvupUvS5ibUiqSz=2JCyYJN1ePgskfW85qyPRGeiKwW2apw@mail.gmail.com>
In-Reply-To: <CAGnRvupUvS5ibUiqSz=2JCyYJN1ePgskfW85qyPRGeiKwW2apw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Henning Rogge <hrogge@gmail.com>
Cc: linux-wpan@vger.kernel.org

On 11/06/2014 07:01 PM, Henning Rogge wrote:
> On Thu, Nov 6, 2014 at 6:55 PM, Carlo Vallati
> <carlo.vallati@iet.unipi.it> wrote:
>> Hi,
>> you can also take a look at this work in progress of mine [0] in which I'm
>> implementing a driver for the Xbee s1 cards.
>> The implementation is still a work in progress, so it has only the basic TX
>> and RX operations and it includes the latest subsystem changes (at least the
>> version included in the 3.16 kernel).
>> The driver communicates with the Xbee s1 card using a serial protocol to
>> receive/send raw data, while most of the 802.15.4 are implemented in
>> hardware (for this reason its structure follows the fakehard.c driver).
> 
> I will have a look at it... thank you.
> 
>> Even if your radio it's not 802.15.4, maybe you can emulate/simulate some of
>> the operations and information needed by the upper layers.
> 
> If I understand the difference between the "soft" and the "hard" style
> drivers right, the soft ones can work with a more stupid hardware,
> correct?

Take a look here [0], in HardMAC devices the MAC layer is implemented in
the device itself, in SoftMAC the MAC layer is mainly implemented in
software, as the hardware is merely a radio transceiver.

[0] https://www.kernel.org/doc/Documentation/networking/ieee802154.txt

> 
> Henning
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
