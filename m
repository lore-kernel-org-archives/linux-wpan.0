Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:58067 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbcGSOs1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Jul 2016 10:48:27 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new implementation
In-Reply-To: <CABBYNZK-zzTzy5uUYd1GVgwiNX9MNpAmWpWUbRyAbOqN0fcNdg@mail.gmail.com>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-21-aar@pengutronix.de> <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de> <CABBYNZL0xFGcW_t-eW9hAL8VOLnp4NYL_iKqChJ8B0srBdEgvQ@mail.gmail.com> <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de> <CABBYNZ+A54MQ3uWGjDVXNOwwX3v3VptZz2UQUNV4_KFKPaV==A@mail.gmail.com> <190983bc-9467-8ff8-436c-ca1fcdfe001b@pengutronix.de> <CABBYNZK-zzTzy5uUYd1GVgwiNX9MNpAmWpWUbRyAbOqN0fcNdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20911.1468939704.1@obiwan.sandelman.ca>
Date: Tue, 19 Jul 2016 10:48:24 -0400
Message-ID: <20912.1468939704@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>

Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
    > And why would we want more than one one net_dev per hci_dev, the
    > rfc7668 only talks about star topology:

    > https://tools.ietf.org/html/rfc7668#section-2.2

    > Bluetooth currently don't have support for a mesh topology, and anyway
    > I don't think the userspace would need to be involved in the selection
    > of the netdev since this is beyond the Bluetooth interface. In PAN for
    > example we end up doing one netdev per connection and the which the
    > userspace managing using a bridge.

BTLE 4.2 moves quite far to supporting a mesh, but doesn't yet get there.
I'm told that it will come.  BTLE 4.2 does support switching to which
star one belongs quickly enough that one could actually route, but it's
probably not practical yet.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

