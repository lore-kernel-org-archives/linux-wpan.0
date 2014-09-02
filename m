Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33787 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbaIBQ0g (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 12:26:36 -0400
Received: by mail-wg0-f43.google.com with SMTP id a1so7086706wgh.26
        for <linux-wpan@vger.kernel.org>; Tue, 02 Sep 2014 09:26:34 -0700 (PDT)
Date: Tue, 2 Sep 2014 18:26:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140902162630.GD15189@omega>
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com>
 <20140901113835.GA21564@omega>
 <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com>
 <20140902071214.GA25800@omega>
 <20140902072627.GB25800@omega>
 <5405D284.7020606@xsilon.com>
 <20140902144327.GA15189@omega>
 <5405D961.4060006@xsilon.com>
 <20140902153742.GC15189@omega>
 <5405EB08.5040006@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5405EB08.5040006@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Sep 02, 2014 at 05:06:32PM +0100, Simon Vincent wrote:
> This is not a problem. There is a fix elsewhere for that.
> 
> I am using local-link addresses.
> 
> I am seeing funny things like:
> lowpan0: received packet from fe80::203:9a00:41:c864 ->
> 7707:ffff:300:0:9a:300:7b3b:3a1a
> 
> Src address fe80::203:9a00:41:c864 does not exist on the network and
> destination address 7707:ffff:300:0:9a:300:7b3b:3a1a does not.
> 

Where do you capture this? You know that wireshark on a lowpan interface
is broken?

- Alex
