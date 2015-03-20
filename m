Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33066 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbCTVmt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 17:42:49 -0400
Received: by wixw10 with SMTP id w10so3005481wix.0
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 14:42:48 -0700 (PDT)
Received: from omega (p20030064A94779B9E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a947:79b9:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id l10sm8019500wje.15.2015.03.20.14.42.47
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 14:42:47 -0700 (PDT)
Date: Fri, 20 Mar 2015 22:42:46 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Advantages and disadvantages of phy/interface set cmd
Message-ID: <20150320214244.GE3952@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I wrote in my previous mails that I will open a new thread to talk about
the advantages and disadvantages of the new set commands for
phy/interface.

1. What is the set phy/interface set command?

See [0], this was a try to introduce the command.

It simple handle all interface and phy setting into their own command.
The current behaviour is to call CMD_SET_CHANNEL. CMD_SET_CCA, etc...
for each phy attribute. With the SET command the setting is determined
if the attribute is set.

The same for interface settings which are MAC settings.


Advantages:

In userspace you setup the whole attrs table of netlink for nl802154 and
simple call only one command which is the SET command.

You can simple keep the old behaviour when you call the SET command and
set only ONE attribute. That should make no difference.

Disadvantages:

If you set more than one attribute and the setting failed between them,
then we need to run some "rollback" for the old values or we simple do
nothing. This is at the moment the at most some -EINVAL or -EOPNOTSUPP returns,
I think we can deal with it when we have more capability flags so a
userspace application can ask before setting if the phy supports that value.

We still need to run then a "rollback" for -EIO and others mistakes but this is
very unlikely. Other solution is to make _nothing_ here and the user
need to react to the error (But userspace application should prevent to
run into such error by getting capabilities).


My opinion:

We should change it because we can still keep the old behaviour and have
"more" easier access for all attributes. So maybe somebody knows more
advantages or disadvantages to contribute this decision.


- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01550.html
