Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:45111 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbcCINp0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Mar 2016 08:45:26 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: RPl on Linux
In-Reply-To: <CAPpUg6OTHiaWvANusmnty0DW0GRonTgX5uOLfR5cOSgbdnYyqQ@mail.gmail.com>
References: <CAPpUg6OTHiaWvANusmnty0DW0GRonTgX5uOLfR5cOSgbdnYyqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30026.1457531123.1@obiwan.sandelman.ca>
Date: Wed, 09 Mar 2016 08:45:23 -0500
Message-ID: <30027.1457531123@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

Baptiste Clenet <bapclenet@gmail.com> wrote:
    > Thanks for your work concerning 6lowpan, 802.15.4 and wpan tools,
    > that's great!  I'm wondering what the status of RPL mesh implementation
    > on Linux?

There are few implementations, see for instance this article:
      http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html

1) Mine, which is at http://unstrung.sandelman.ca/
   Currently storing only; non-storing requires kernel work
   that is not yet done.

2) https://github.com/joaopedrotaveira/linux-rpl
   which lives in the kernel.

3) https://github.com/tcheneau/simpleRPL
   I've not looked at this one at all.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

