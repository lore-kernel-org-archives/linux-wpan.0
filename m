Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34014 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbDNLte (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Apr 2015 07:49:34 -0400
Date: Tue, 14 Apr 2015 13:49:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: creating infrastructure for generic 6LoWPAN branch
Message-ID: <20150414114917.GA2179@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, kernel@pengutronix.de

Hi,

I was thinking about to create some infrastructure to handle generic
6LoWPAN development things, which is shared between bluetooth and
802.15.4. I mean everything which is in "net/6lowpan" and things which
are 6LoWPAN "specific/related/mostly used in 6LoWPAN" and works in L3 and
upper layers.

What we should need is some kind of website which contains a ToDo list
of everything which is outside there and what we currently support. I
mean a general information site for "6LoWPAN" implementation inside
Linux kernel.

Additionally we need some repository which contains some userspace tools
for handling generic 6LoWPAN things like userspace configuration tool
for the 6LoWPAN nhc layer. These tools can be used then for all 6LoWPAN
implementations (BTLE/802.15.4 at the moment). That was one idea which
was discussed while bringing nhc layer mainline.

Any ideas where we should host this site, do we really need this or
any others suggestions?

- Alex
