Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:36676
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbcHALiH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Aug 2016 07:38:07 -0400
Subject: Re: Looking for boards with an 802.15.4 chip
References: <20160728174051.GB75405@redhat.com>
 <e65bd287-bfba-c92b-ac64-0e1c758a3e03@datenfreihafen.org>
 <CAP3K90dJt7cbo54dhwXKfTGSJpXt=24S2bRa1NL57uhp1dx8Hg@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <20665066-ab7f-a5ef-2e67-6767f025b336@osg.samsung.com>
Date: Mon, 1 Aug 2016 13:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAP3K90dJt7cbo54dhwXKfTGSJpXt=24S2bRa1NL57uhp1dx8Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcin K Szczodrak <mszczodrak@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Don Zickus <dzickus@redhat.com>, "aar@pengutronix.de" <aar@pengutronix.de>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linville@redhat.com" <linville@redhat.com>

Hello.

On 01/08/16 00:34, Marcin K Szczodrak wrote:
> To just get a feeling of how the technology works, OpenThread is one
> way of discovering 15.4 and it's Thread standard. One can use various
> dev boards to run OpenThread, such as Zolertia's RE-Mote or TI's
> CC2538 dev kit. Alternatively, there are also very good kits from
> SiLabs, NXP (Freescale) and Dialog (check OpenThread Sandbox
> Development Platform).
>
> From a Linux perspective, it might be worth playing with OpenThread
> and wpantund, a user-space 15.4 driver that talks to 15.4 radio chip
> over UART or SPI.

We are aware of them and I already has some mails with Jonathan from 
Nestlabs to see how we can work together here.


In this setup, one could flash 15.4 with OpenThread
> and run wpantund on a Linux host to create a Thread network gateway,
> which typically is used by low-power 15.4 only devices to get outside
> of the Thread network.

What you are describing is the network co-processor setup (NCP). This 
sadly means that Linux is only aware of the very high level 
characteristics of the Thread network. IP address range, routes, etc.
The rest would all be handled in the device firmware. With OpenThread 
this would be at least open source.

On the other hand the linux-wpan and 6LoWPAN stack we are working on 
here is capable of handling the PHY and MAC layers as well. Thus we are 
aiming for a way to run the higher level bits of OpenThread in userspace 
while having at least 15.4 and 6LoWPAN be dealt with by the existing 
subsystems. I'm working my way through the code right now to see what is 
needed on our side to support the OpenThread use cases and what 
interfaces we would need to offer. I should be able to but some initial 
thoughts into the wiki by the end of the week maybe.

In my opinion the NCP as well as the native linux use case are both 
valid and it depends on your idea or project/product what you want to use.

regards
Stefan Schmidt
