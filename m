Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:39154 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfA2M5V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Jan 2019 07:57:21 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so4302371itl.4
        for <linux-wpan@vger.kernel.org>; Tue, 29 Jan 2019 04:57:20 -0800 (PST)
Date: Tue, 29 Jan 2019 07:57:08 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC net-next 1/4] net: Reserve protocol identifiers for EnOcean
Message-ID: <20190129125708.plsbgcpcwhtezgo5@x220t>
References: <20190129050130.10932-1-afaerber@suse.de>
 <20190129050130.10932-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129050130.10932-2-afaerber@suse.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, support@enocean.com

Hi,

On Tue, Jan 29, 2019 at 06:01:27AM +0100, Andreas Färber wrote:
> EnOcean wireless technology is based on ASK (ERP1) and FSK (ERP2) modulations
> for sub-GHz and on IEEE 802.15.4 for 2.4 GHz.
> 

I am not sure what you try to do here. If I see that correctly you
want to add for some special protocol vendor specific transceiver which
is underneath an 802.15.4 transceiver a new ARPHRD type and even more
for each modulation what it supports?

If it's a 802.15.4 transceiver why not using the 802.15.4 subsystem?

For me it sounds more like a HardMAC transceiver driver for doing the
vendor protocol. The different modulations is part of a 802.15.4 phy
device class. Similar like in wireless.

- Alex
