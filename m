Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33205 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbbFXOBV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 10:01:21 -0400
Received: by wgck11 with SMTP id k11so37291370wgc.0
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jun 2015 07:01:20 -0700 (PDT)
Date: Wed, 24 Jun 2015 16:01:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150624140111.GA12381@omega>
References: <20150618123154.GB6640@omega>
 <5582E6FA.3020101@osg.samsung.com>
 <5582EAAD.1090605@xsilon.com>
 <55831F48.4090905@osg.samsung.com>
 <55897C92.1060207@xsilon.com>
 <20150624100011.GA21293@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150624100011.GA21293@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 24, 2015 at 12:00:14PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Tue, Jun 23, 2015 at 04:34:42PM +0100, Simon Vincent wrote:
> > Hi Alex,
> > 
> > Do you have your security/nl802154 work available anywhere I can have a
> > look?
> > I am in the process of getting 802.15.4 security working on our devices. I
> > don't want to implement it using the old interface as I will then have to
> > recode our application when llsec moves over to nl802154.
> 
> I think what we do at first is a 1:1 implementation of the old interface
> and the new interface and then look what we can change afterwards if
> needed.
> 
> We introduce then some CONFIG_NL802154_EXPERIMENTAL to change the enum
> definition (with security and without). I think then we are somehow
> safe to still change the netlink interface, inside kernelspace, afterwards.
> 

What I meant here is something like [0]. We simple let the config add
the end of all declaration, if we add something to mainline then we put
it out of the #ifdef foo. (Above the comments) If we do that then the
CONFIG_NL802154_EXPERIMENTAL will be broken afterwards and the userspace
tool need to be updated. Without CONFIG_NL802154_EXPERIMENTAL it should
always be the same. Just the NL802154_CMD_MAX and NL802154_ATTR_MAX
will be a lesser value than without CONFIG_NL802154_EXPERIMENTAL. The
internal nl802154 framework should not react on these definitions then,
if somebody tries to use CMD's/ATTR's which are inside
CONFIG_NL802154_EXPERIMENTAL.


With CONFIG_NL802154_EXPERIMENTAL then the user need to care about to user
the right userspace nl802154 header in their application.

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/commit/4522252b9964227d1a3ce0b09c1aa0a6d95c3ba1
