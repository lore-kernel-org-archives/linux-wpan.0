Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37166 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbcCJJKJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Mar 2016 04:10:09 -0500
Received: by mail-wm0-f44.google.com with SMTP id p65so19419562wmp.0
        for <linux-wpan@vger.kernel.org>; Thu, 10 Mar 2016 01:10:08 -0800 (PST)
Date: Thu, 10 Mar 2016 10:10:02 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: =?utf-8?Q?PROBLEM=EF=BC=9Athere_exist?= =?utf-8?Q?s?= a wrong
 return value of function ieee802154_add_iface()
Message-ID: <20160310090957.GA5020@omega>
References: <485cdac3.48e1.1535e928b67.Coremail.rucsoftsec@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <485cdac3.48e1.1535e928b67.Coremail.rucsoftsec@163.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Zhang Yan <rucsoftsec@163.com>
Cc: linux-wpan@vger.kernel.org, stefan@osg.samsung.com

Hi,

I think this is a good time to remove the deprecated netlink interface
for 802.15.4.

Stefan please say your opinion here. There should be really nobody which
use this interface anymore.

- Alex
