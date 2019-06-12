Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io1-f51.google.com ([209.85.166.51]:34798 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389772AbfFLUAD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jun 2019 16:00:03 -0400
Received: by mail-io1-f51.google.com with SMTP id k8so14052837iot.1
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jun 2019 13:00:03 -0700 (PDT)
Date: Wed, 12 Jun 2019 15:59:58 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Simulating 6lowpan with mac802154_hwsim
Message-ID: <20190612195958.ukblxedzxwr6hvdk@x220t>
References: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
 <20190612141016.owy6csdatcugsgak@x220t>
 <CAK8U23ZW+4MXkTcmzR9VV=Kw__wfEoXqvphEbH7ZPSe7rGH2Gw@mail.gmail.com>
 <20190612172028.2fxq6jsj5jsq5pca@x220t>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612172028.2fxq6jsj5jsq5pca@x220t>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Jun 12, 2019 at 01:20:28PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Wed, Jun 12, 2019 at 02:07:26PM -0300, Ramon Fontes wrote:
> > One node (e.g. node1) can be connected simultaneously to multiple
> > nodes  (e.g. node2 and node3) by using only one 6lowpan interface.
> > That said, which node (2 or 3) will node1 taking into account? They
> > can have different distances and only one interface in which we can
> > use TC. Please correct me if I'm wrong. In my mind, the same is true
> > for LQI.
> > 
> 
> For TC it's true, then you need to match on different addresses e.g. mac
> address/short address?

After talking with the TC maintainer, he told me it's implemented as
qdisc and not as action where you probably could do something to use
netem features per neighbor as run on specifc patterns...

- Alex
