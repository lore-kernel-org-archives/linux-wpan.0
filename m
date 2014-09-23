Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:47854 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaIWJft (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 05:35:49 -0400
Received: by mail-we0-f178.google.com with SMTP id t60so4276903wes.37
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 02:35:48 -0700 (PDT)
Date: Tue, 23 Sep 2014 11:35:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140923093544.GB12857@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923092653.GA12857@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140923092653.GA12857@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

Jukka,

I/Simon mainly add you here in cc because this bug what Simon fixed here
is also inside of bluetooth 6lowpan.

I see now [0]. And it seems to me that this also occurs at bluetooth
branch. Do you have any questions on how the fix now is? Sorry, but I
need to clarify that you understood this issue and you/others prepare a
patch for this.

- Alex

[0] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L509
