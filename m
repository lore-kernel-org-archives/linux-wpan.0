Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36568 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbFXKAX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 06:00:23 -0400
Received: by wicnd19 with SMTP id nd19so130276818wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jun 2015 03:00:22 -0700 (PDT)
Date: Wed, 24 Jun 2015 12:00:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150624100011.GA21293@omega>
References: <20150618123154.GB6640@omega>
 <5582E6FA.3020101@osg.samsung.com>
 <5582EAAD.1090605@xsilon.com>
 <55831F48.4090905@osg.samsung.com>
 <55897C92.1060207@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55897C92.1060207@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Tue, Jun 23, 2015 at 04:34:42PM +0100, Simon Vincent wrote:
> Hi Alex,
> 
> Do you have your security/nl802154 work available anywhere I can have a
> look?
> I am in the process of getting 802.15.4 security working on our devices. I
> don't want to implement it using the old interface as I will then have to
> recode our application when llsec moves over to nl802154.

I think what we do at first is a 1:1 implementation of the old interface
and the new interface and then look what we can change afterwards if
needed.

We introduce then some CONFIG_NL802154_EXPERIMENTAL to change the enum
definition (with security and without). I think then we are somehow
safe to still change the netlink interface, inside kernelspace, afterwards.

> I have some spare time at the moment to develop/review/test the security
> layer.
> 

Too bad I have at the moment really nothing which you can test/review
maybe we can do some split working of development tasks, but I don't have
the overview at the moment to split anything.

For general I would say somebody can do the userspace side and another one
can do the kernelspace side. At the end we trying to fit anything together.

For me it's _very_ important that the userspace side should not have
some big mechanism to setup the kernelspace stuff. We should provide
some config file to setup the most part, instead doing iwpan calls over
command line.

Phoebe also reported that we need to save the current dump of the whole
security information in case of a reboot and restore them afterwards
again. (e.g. the frame counter attribute). This all smells more like a
daemon which running in the background and deals with some configfiles
and states (dumping security tables in case of reboot).

- Alex
