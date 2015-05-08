Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33837 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbEHQsk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 12:48:40 -0400
Received: by wicmx19 with SMTP id mx19so40589378wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 09:48:39 -0700 (PDT)
Date: Fri, 8 May 2015 18:48:36 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: netlink 802154
Message-ID: <20150508164831.GB15416@omega>
References: <554CE644.50801@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <554CE644.50801@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, May 08, 2015 at 06:37:24PM +0200, Matteo Petracca wrote:
> Dear all,
> I would like to write a user space application using the new nl802154.
> Do you have any example?
> 

General example would be [0]. Also you can search for stuff to talk with
nl80211, which should be the same. We have different enums defines, but
making a general netlink communication should be the same.



BIG WARNING:

this interface is still in development. We currently not guarantee that
the interface is always the same! I will try to do my best for backwards
compatibility.

- Alex

[0] https://github.com/linux-wpan/wpan-tools
