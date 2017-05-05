Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34737 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754228AbdEEUKN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 5 May 2017 16:10:13 -0400
Received: by mail-wr0-f176.google.com with SMTP id l9so9482379wre.1
        for <linux-wpan@vger.kernel.org>; Fri, 05 May 2017 13:10:12 -0700 (PDT)
Received: from omega (p20030064A906BC11286E4959969D9F1E.dip0.t-ipconnect.de. [2003:64:a906:bc11:286e:4959:969d:9f1e])
        by smtp.gmail.com with ESMTPSA id p17sm3087207wmd.11.2017.05.05.13.10.10
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 May 2017 13:10:10 -0700 (PDT)
Date: Fri, 5 May 2017 22:10:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: monitor interfaces and fcs
Message-ID: <20170505201000.hprmmtwsfi6jy7uf@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I want to prepare the fakelb extensioni (mainline) [0] to create phy mesh
topologies and want to fix at first a behaviour in monitor interfaces because
somehow it's crazy whats going on...

It's because node and monitor interfaces have different _default_ behaviours
if fcs is present or not and we have users for AF_PACKET RAW for node
and monitor interfaces (but I think only on monitors it makes more
sense, without syncing address filters).

The difference is at rx side default behaviour (which you also cannot
change):

On rx side:

Node: doesn't send FCS to userspace

Monitor: send FCS to userspace (which makes sense for sniffing)

It was some behaviour which is good for wireshark stuff... but having
this mixed it's difficult to handle AF_PACKET RAW sockets in userspace.
It's because with the current behaviour you cannot run you AF_PACKET
software on nodes and monitors -> evaluate the type before would fix
it... but I want it somehow "easy" to not make nl802154 magic.

It means: If you develop for monitors -> it will not run on nodes and
vice versa interface types.

On tx side:

This is current complicated, we don't have driver callback support to
disable fcs on hardware side, both doesn't require a FCS.

---

New behaviour?:

The new behaviour should also deal with hardware where we don't get FCS
information from hardware (cc2520 in non promicuousmode is such
hardware).

This means (new default handling):

Rx:
Monitor and Nodes will not deliver FCS

Tx:
Monitor and Nodes don't need to send frames with FCS

Important node - you can change this behaviour for monitors:

Rx: while monitor interface generation you can decide if you want FCS

Tx: while monitor interface generation you can decide if you want to
    send FCS

If the hardware doesn't support that - it will not allow you to generate
such interface.

If you run AF_PACKET userspace software which doesn't check on these
"flags" if FCS on rx/tx is needed - it will not work unless you fix
userspace software.

---

IMPORTANT NOTE:
This will of course break userspace software - fix should be simple, but
it's already broken somehow. E.g. tx with wireshark, it thinks there is
a FCS there, but there is no FCS...

We should fix all userspace software afterwards...

What we need is just some behaviour which everybody acks now and we
don't touch it again! Please comment this mail with your opinions about
default behaviours of FCS and different interface types (node vs
monitor) in combination with AF_PACKET RAW.

- Alex

[0] https://www.netdevconf.org/2.1/session.html?aring
