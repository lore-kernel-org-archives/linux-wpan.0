Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:51422 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbaJVKLz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 06:11:55 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so890045wiv.0
        for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2014 03:11:54 -0700 (PDT)
Date: Wed, 22 Oct 2014 12:35:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Message-ID: <20141022103516.GA10402@x61s.guest.pengutronix.de>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
 <20141022082919.GA1603@x61s.guest.pengutronix.de>
 <CAFUtXGw=Nb=bB5rWLDyK++KO55VRCqP6FqonWV2idpUR6si_jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUtXGw=Nb=bB5rWLDyK++KO55VRCqP6FqonWV2idpUR6si_jQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: "Zhang, Baoli" <baoli.zhang@intel.com>, "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 22, 2014 at 12:00:56PM +0200, Maciej Wasilak wrote:
> Hi,
> 
> 2014-10-22 10:29 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> 
> >
> > Little how to is available at [3], this is the old linux-zigbee trac
> >
> 
> There is a very decent howto for RaspberryPi at [0], however it is based on
> net-next branch. linux-wpan contributes in some organized way to net-next,
> right?

yea, linux-wpan-next/linux-wpan is based on linux-bluetooth-next/linux-bluetooth.

Current behaviour is now send everything to linux-bluetooth-next/linux-bluetooth
or linux-wpan-next/linux-wpan. Should make no difference, I will try to
make git rebase linux-wpan when new related things for 802.15.4 came in.
But please tag it with linux-bluetooth/linux-bluetooth-next.

Now after linux-bluetooth, bluetooth maintainers send pull request to
linux-wireless. Then linux-wireless send pull-request to net-next. net-next
sends pull request to linus.


Why we make this behaviour?

This is currently because the GENERIC 6LOWPAN branch which is used by
linux-bluetooth and linux-wpan. These branch should be up-to-date on
both branches. When the GENERIC 6LOWPAN comes into a state when no
conflicts occurs anymore, because we have no much conflicts there
anymore. Then linux-wpan will send pull request to linux-wireless like
the bluetooth branch.

- Alex
