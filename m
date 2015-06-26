Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35969 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbbFZJcc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Jun 2015 05:32:32 -0400
Received: by wguu7 with SMTP id u7so83489158wgu.3
        for <linux-wpan@vger.kernel.org>; Fri, 26 Jun 2015 02:32:31 -0700 (PDT)
Date: Fri, 26 Jun 2015 11:32:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150626093218.GA5074@omega>
References: <20150618123154.GB6640@omega>
 <5582E6FA.3020101@osg.samsung.com>
 <5582EAAD.1090605@xsilon.com>
 <55831F48.4090905@osg.samsung.com>
 <55897C92.1060207@xsilon.com>
 <20150624100011.GA21293@omega>
 <20150624140111.GA12381@omega>
 <558D13C4.6000800@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <558D13C4.6000800@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jun 26, 2015 at 09:56:36AM +0100, Simon Vincent wrote:
> Ok yes this makes sense.
> 
> Let me know if there is any bits I can help on.
> 

I added more stuff into the branch [0], fix some embarrassingly mistakes.

Yesterday I talked with Phoebe about "very simple to use" usecase for
the userspace application.

In the discussion we end with the idea to have an userspace application
for load/store the security mib.

Phoebe said it should be something like what iptables do:

Like "ip6tables-save" and "ip6tables-restore".

This will simple save the actual mib in a file and restore them from file,
these files should contain the same file format for representing the mib.
Later there should be also the possibility to change the mib during
runtime while a mib is already loaded, but at first the save/restore
sounds the most use case. You can still manipulate the mib security
structure in the configuration file which represents the mib, but need
to run a completely restore afterwards.


Maybe we can start a discussion about the "file format" which represents
the mib. This should be some simple format. Not xml/json which
adds library dependencies.

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/tree/nl802154_llsec
