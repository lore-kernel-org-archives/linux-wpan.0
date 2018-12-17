Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35599 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbeLQN65 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Dec 2018 08:58:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so12697362wmh.0
        for <linux-wpan@vger.kernel.org>; Mon, 17 Dec 2018 05:58:56 -0800 (PST)
Date: Mon, 17 Dec 2018 14:51:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v5 0/6] net: lorawan: Add LoRaWAN soft MAC module
Message-ID: <20181217135119.GF2096@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216101858.9585-1-starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org

Sun, Dec 16, 2018 at 11:18:53AM CET, starnight@g.ncu.edu.tw wrote:
>LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
>devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.
>
>LoRaWAN networks typically are laid out in a star-of-stars topology in
>which gateways relay messages between end-devices and a central network
>server at the backend.  Gateways are connected to the network server via
>standard IP connections while end-devices use single hop LoRa(TM) or FSK
>communication to one or many gateways.
>
>A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
>optional features (Class B, Class C ...):
>* Bi-directional end-devices (Class A)
>* Bi-directional end-devices with scheduled receive slots (Class B)
>* Bi-directional end-devices with maximal receive slots (Class C)
>
>This patch set add LoRaWAN class module implementing the stack,
>especially the soft MAC, between socket APIs and LoRa device drivers.
>
>socket APIs:
>send and receive the data
>------------------------------------------------------------------------
>LoRaWAN class module implements soft MAC:
>append the header/footer, encryption/decryption, timing slot and MAC
>commands
>------------------------------------------------------------------------
>LoRa device drivers:
>send and receive the messages for MAC layer
>------------------------------------------------------------------------
>LoRa devices
>
>This module starts from simple and implements partial Class A
>end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
>More features and complexity, for example regional parameters, confirmed
>data messages, join request/accept messages for Over-The-Air Activation,
>MAC commands ... will be added in the future.

Could you please send new patchset versions as separate patchsets? It is
messy to have all versions in one thread. Also, please send it so the
patches are in-reply-to the cover letter (git-send-email default).

Thanks!
