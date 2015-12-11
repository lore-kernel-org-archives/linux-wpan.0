Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:52319 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbLKNH0 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 11 Dec 2015 08:07:26 -0500
Subject: Re: ieee802154-atusb: Delete an unnecessary check before the function
 call "kfree_skb"
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <564B5327.4010307@osg.samsung.com>
 <564B5344.1090200@osg.samsung.com> <56695093.8080605@osg.samsung.com>
 <7DCE62A2-DEA0-4ABF-A0D6-4EE00BDFFE95@holtmann.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <566ACA84.6080603@users.sourceforge.net>
Date: Fri, 11 Dec 2015 14:07:16 +0100
MIME-Version: 1.0
In-Reply-To: <7DCE62A2-DEA0-4ABF-A0D6-4EE00BDFFE95@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

> this slipped through, but now it does no longer apply.
> 
> Applying: ieee802154-atusb: Delete an unnecessary check before the function call "kfree_skb"
> error: patch failed: drivers/net/ieee802154/atusb.c:310
> error: drivers/net/ieee802154/atusb.c: patch does not apply
> Patch failed at 0001 ieee802154-atusb: Delete an unnecessary check before the function call "kfree_skb"

How can this hiccup happen?

A command like the following is still working for me on source files
for the software "Linux next-20151211".

elfring@Sonne:~/Projekte/Linux/next-patched> git apply ~/Projekte/Bau/Linux/scripts/Coccinelle/deletions1/next/20151113/Flicken/0001-ieee802154-atusb-Delete-an-unnecessary-check-before.patch

Regards,
Markus
