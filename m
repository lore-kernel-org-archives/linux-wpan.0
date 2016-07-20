Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:40507 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753159AbcGTKXG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Jul 2016 06:23:06 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160720073944.GA20780@t440s>
Date: Wed, 20 Jul 2016 13:22:59 +0300
Content-Transfer-Encoding: 8BIT
Message-Id: <D2524A03-DF9F-4AA2-A046-C8FC1AADB1C1@holtmann.org>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-21-aar@pengutronix.de> <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de> <CABBYNZL0xFGcW_t-eW9hAL8VOLnp4NYL_iKqChJ8B0srBdEgvQ@mail.gmail.com> <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de> <CABBYNZ+A54MQ3uWGjDVXNOwwX3v3VptZz2UQUNV4_KFKPaV==A@mail.gmail.com> <190983bc-9467-8ff8-436c-ca1fcdfe001b@pengutronix.de> <20160719054501.GA17979@t440s.P-661HNU-F1> <CABBYNZ+epQ6LPP4PfwXAstim_h5yY78GgbVLEH-i96g6u8p_Dw@mail.gmail.com> <ae47fe95-3599-d3f7-49bf-66c02b067fca@pengutronix.de> <20160720073944.GA20780@t440s>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Alexander Aring <aar@pengutronix.de>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>, carlesgo@entel.upc.edu

Hi Johan,

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

of course we do not want to leak the identity address if we don't have to. That is why I am thinking that the IPv6 link should always use something close to the link layer address.

The basic assumption should be that when hci0 is powered on, then you get a 6lo network interface. If you power the controller down, then the 6lo interface gets removed.

By default, the 6lo interface should not have a single address assigned to it if there are no connections. When a connection is created, then a new address should be assigned to it. If the connection drops, then it should be removed. And of course there needs to be usage counter attached to each address. If two connections use the same address, then it only gets removed once there is no connection with that source address active anymore (meaning it needs some sort of reference counting).

With usage of public address or static random address, then most likely only one address on 6lo interface is used. This is not strictly mandated by the spec since you can in theory have one connection with a public address and the other with the static random address. However ignore that fact for a bit since it will just work out when dealing with RPAs anyway. The importance is the link layer address that is used when establishing the connection.

In case you use RPAs, then every connection will have a new link layer address (we rotate the RPA when disabling advertising). As long as the connection is active, that source address should be represented on 6lo interface. However this is no difference either since per spec each new connection can have a different address from all the existing connections. That is always valid with the link layer.

Regards

Marcel

