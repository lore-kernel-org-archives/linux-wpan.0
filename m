Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:36755 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbAHG3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Jan 2015 01:29:37 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 0/5] ieee802154: structural directory changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 7 Jan 2015 22:29:30 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <7251D830-A187-42EE-BF7B-F54AC11F5E87@holtmann.org>
References: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series contains patches to create a 6lowpan sub-directory inside
> ieee802154. At least we handle receive and transmit functionality in separate
> files.
> 
> This series based on previous the previous series:
> 
> "ieee802154: 6lowpan: separate receive/transmit functionality" and
> "ieee802154: structural directory changes".
> 
> I changed PATCH 1/5 "ieee802154: create 6lowpan sub-directory" only to source
> the "net/ieee802154/6lowpan/Kconfig" file. Furthermore there will more options
> like debugfs etc... available for ieee802154 6lowpan functionality.
> 
> - Alex
> 
> Alexander Aring (5):
>  ieee802154: create 6lowpan sub-directory
>  ieee802154: 6lowpan: rename internal header
>  ieee802154: 6lowpan: move receive functionality
>  ieee802154: 6lowpan: move transmit functionality
>  ieee802154: 6lowpan: rename to core
> 
> net/ieee802154/6lowpan/6lowpan_i.h        |  72 +++
> net/ieee802154/6lowpan/Kconfig            |   5 +
> net/ieee802154/6lowpan/Makefile           |   3 +
> net/ieee802154/6lowpan/core.c             | 304 +++++++++++++
> net/ieee802154/{ => 6lowpan}/reassembly.c |   2 +-
> net/ieee802154/6lowpan/rx.c               | 171 +++++++
> net/ieee802154/6lowpan/tx.c               | 271 +++++++++++
> net/ieee802154/6lowpan_rtnl.c             | 729 ------------------------------
> net/ieee802154/Kconfig                    |   6 +-
> net/ieee802154/Makefile                   |   3 +-
> net/ieee802154/reassembly.h               |  41 --
> 11 files changed, 829 insertions(+), 778 deletions(-)
> create mode 100644 net/ieee802154/6lowpan/6lowpan_i.h
> create mode 100644 net/ieee802154/6lowpan/Kconfig
> create mode 100644 net/ieee802154/6lowpan/Makefile
> create mode 100644 net/ieee802154/6lowpan/core.c
> rename net/ieee802154/{ => 6lowpan}/reassembly.c (99%)
> create mode 100644 net/ieee802154/6lowpan/rx.c
> create mode 100644 net/ieee802154/6lowpan/tx.c
> delete mode 100644 net/ieee802154/6lowpan_rtnl.c
> delete mode 100644 net/ieee802154/reassembly.h

all 5 patches haven been applied to bluetooth-next tree.

Regards

Marcel

