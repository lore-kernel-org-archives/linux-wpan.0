Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35310 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbbFRMb7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 08:31:59 -0400
Received: by wiga1 with SMTP id a1so169731853wig.0
        for <linux-wpan@vger.kernel.org>; Thu, 18 Jun 2015 05:31:58 -0700 (PDT)
Received: from omega (p20030064A92BCD89E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a92b:cd89:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id v3sm12919290wix.8.2015.06.18.05.31.57
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 05:31:57 -0700 (PDT)
Date: Thu, 18 Jun 2015 14:31:55 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: The 802.15.4 Security Layer
Message-ID: <20150618123154.GB6640@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi all,

I saw the latest discussion about the security layer and wants to open a
new thread about discussion for access this layer over nl802154 and
putting a "very easy to use" functionality into iwpan.

I need to admit, I never tested myself this layer, also I told many
times that the step to put security layer functionality into nl802154 is
a necessary step. For that reason I declare the security layer as broken.

Several months ago I started to put these functionality into wpan-tools
and nl802154. It's just parsing a file at the moment and putting the all
relevant entries for key, device, seclevel tables in cfg802154. Nothing
more. These tables are handled like an ACL in 802.15.4 (so far I know)
and necessary to do the "key lookup" procedure, on receiving decrypted
frames.

At weekend I will try to provide my stuff which I already have done and
will try to explain what the idea for the next necessary steps are. It's
just to start a discussion "How do deal with accessing llsec over 
nl802154/cfg802154".

After we can accessing the sec layer over nl802154, we can hopefully remove
the old interface stuff.

Does this sounds like a plan?

Thanks.

- Alex

