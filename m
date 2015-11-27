Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34040 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbbK0MNn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Nov 2015 07:13:43 -0500
Date: Fri, 27 Nov 2015 13:13:34 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next 0/7] GHC compression detection
Message-ID: <20151127121330.GA28084@omega>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org

On Wed, Nov 25, 2015 at 03:59:10PM +0100, Stefan Schmidt wrote:
> Hello.
> 
> This is a first stab at RFC7400. So far we only hook into the NHC framework to
> detect the registered GHC types (extension headers, UDP and ICMPv6).
> This is aligned with how we detect the NHC frames.
> 

TODO for next is to make possible that we can load multiple nhc modules
for the transmit side. We have a 1(tranmit):n(receive) mapping here, and
we should support all nhc's for receive side.

For tranmsmit side we should have a disable by default and offer a
debugfs entry (nhc framework debugfs support) to enable/disable it
at runtime. It's a 1:nexhdr mapping, so only one for nexthdr can running
at the same time currently. If somebody tries that it should be return
-EBUSY.

I would suggest additional patches:

1. Allow to have register everything and disable compression methods of
   all nhcs by default. The receive handling should always possible,
   the compression should be disabled by default because other 6LoWPAN
   stacks may not support e.g. GHC types.

   Maybe we can do a nhc directory for the debugfs interface related entry
   for that. So the nhc framework offers some support e.g. enable compression
   for nhc xy.

2. Add all you nhc's _after_ all other nhc modules. This will occur that
   the first ones has a higher priority. Our priority strategy is then
   like the order of the list. See [0].

3. Add "default y" to all nhc's for support receiving always.


That's huge work, but maybe the next steps.

Otherwise it's looking good and let the NHC framework as first known
about these next header compressions, so:

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex

[0] http://lxr.free-electrons.com/source/net/6lowpan/core.c#L24
