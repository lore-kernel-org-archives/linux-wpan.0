Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbeHEPyI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 5 Aug 2018 11:54:08 -0400
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
References: <20180701110804.32415-1-afaerber@suse.de>
 <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
 <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <b7d67853-2b22-e9c3-edb5-85f937d95c5c@suse.de>
Date: Sun, 5 Aug 2018 15:49:20 +0200
MIME-Version: 1.0
In-Reply-To: <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Ben Whitten <Ben.Whitten@lairdtech.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "contact@snootlab.com" <contact@snootlab.com>, Brian Ray <brian.ray@link-labs.com>, "lora@globalsat.com.tw" <lora@globalsat.com.tw>, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>, Hasnain Virk <Hasnain.Virk@arm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, Daniele Comel <dcomel@mipot.com>, linux-wpan <linux-wpan@vger.kernel.org>

Hi Ben and Jian-Hong,

[- SPI - devicetree]

Am 18.07.2018 um 13:28 schrieb Ben Whitten:
>> Meanwhile my attempt to play with netlink during SUSE
>> Hackweek has been
>> going slow and I could use some guidance or a volunteer to
>> contribute: I
>> have a bare skeleton of registration, commands, attributes
>> and multicast
>> groups, but no plan yet how to connect that to the actual
>> drivers to
>> query or apply the settings...
> 
> Happy to help, I will be starting from zero on netlink but I can contribute my existing work incorporating Marks comments for sx1301 etal.

I've figured out a way to retrieve a frequency value via netlink:
By passing the lora0 ifindex in as attribute, nllora can look up the
net_device by index, and then via struct lora_dev_priv call into hooks
that the device drivers can optionally implement. :)

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/net/lora/netlink.c?h=lora-next

Tested with HIMO-01M module.
The command might need an additional channel attribute for SX130x.

The corresponding nltest program (using libnl-genl) is here:
https://github.com/afaerber/lora-modules/blob/master/nltest.c

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
