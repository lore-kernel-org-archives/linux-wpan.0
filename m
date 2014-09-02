Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54757 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaIBPhr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 11:37:47 -0400
Received: by mail-wi0-f182.google.com with SMTP id z2so8147989wiv.3
        for <linux-wpan@vger.kernel.org>; Tue, 02 Sep 2014 08:37:46 -0700 (PDT)
Date: Tue, 2 Sep 2014 17:37:44 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140902153742.GC15189@omega>
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com>
 <20140901113835.GA21564@omega>
 <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com>
 <20140902071214.GA25800@omega>
 <20140902072627.GB25800@omega>
 <5405D284.7020606@xsilon.com>
 <20140902144327.GA15189@omega>
 <5405D961.4060006@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5405D961.4060006@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

I saw this right now [0].

This is how an eui48 is converted to eui64. But we have already a
neui64. Are you sure this code check on this?

Normally it should check if the dev addr_len is 64 bit long, then it's a
eui64 address.

I don't see any test on this. That's why it works on a ethernet device
and not on a 802.15.4 lowpan device type.

- Alex

[0] https://github.com/smee204/unstrung/blob/all_fixes/lib/libndmgmt/iface.cpp#L91
