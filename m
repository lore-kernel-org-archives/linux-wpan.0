Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34583 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbcGTIOh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Jul 2016 04:14:37 -0400
MIME-Version: 1.0
In-Reply-To: <20160720073944.GA20780@t440s>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-21-aar@pengutronix.de>
 <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de> <CABBYNZL0xFGcW_t-eW9hAL8VOLnp4NYL_iKqChJ8B0srBdEgvQ@mail.gmail.com>
 <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de> <CABBYNZ+A54MQ3uWGjDVXNOwwX3v3VptZz2UQUNV4_KFKPaV==A@mail.gmail.com>
 <190983bc-9467-8ff8-436c-ca1fcdfe001b@pengutronix.de> <20160719054501.GA17979@t440s.P-661HNU-F1>
 <CABBYNZ+epQ6LPP4PfwXAstim_h5yY78GgbVLEH-i96g6u8p_Dw@mail.gmail.com>
 <ae47fe95-3599-d3f7-49bf-66c02b067fca@pengutronix.de> <20160720073944.GA20780@t440s>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Jul 2016 11:14:34 +0300
Message-ID: <CABBYNZLdeCqJNT=-aDBMAK5yG2HVYGXzd-dL+gVe7BBnjmckcA@mail.gmail.com>
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new implementation
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>, carlesgo@entel.upc.edu

Hi Johan,

On Wed, Jul 20, 2016 at 10:39 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Alex,
>
> On Tue, Jul 19, 2016, Alexander Aring wrote:
>> mhhh, I am not a bluetooth expert. What really means "periodically
>> change is RPA" and how is this done in the Linux bluetooth?
>>
>> When "changing the RPA" happens, does that mean the all connections will
>> be lost (unregister interface). Then the previous connections will be
>> recreated (register interface) with a complete different MAC address?
>
> Connections aren't lost when the random address is changed. That's why
> we track the hci_conn->init_addr and hci_conn->resp_addr. The way this
> is dealt with e.g. the Security Manager protocol is that the connection
> creation address *is* the address for the remote device throughout the
> entire connection, no matter what happens to the local and remote random
> address during the connection. I would expect 6LoWPAN do do something
> similar.
>
> What was still unclear to me (maybe I missed it in the thread): does the
> 6LoWPAN for LE spec require using the connection creation address or the
> identity address? If it would be the latter then that's something that
> will never change and the whole interface recreation issue goes away.

For the MAC address I don't really know, but for the link-local IPv6
address I think the RPA shall be used:

   'The IPv6 link-local address configuration described in Section 3.2.2
   only reveals information about the 6LN to the 6LBR that the 6LBR
   already knows from the link-layer connection.  This means that a
   device using Bluetooth privacy features reveals the same information
   in its IPv6 link-local addresses as in its device addresses.
   Respectively, a device not using privacy at the Bluetooth level will
   not have privacy at the IPv6 link-local address either.'

-- 
Luiz Augusto von Dentz
