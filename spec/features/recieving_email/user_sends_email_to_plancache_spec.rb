feature 'User sends email to PlanCache' do
  before(:each) do
    @valid_token_base64 = SecureRandom.urlsafe_base64(6, false)
    @valid_to = [{ full: "Joe Bloggs <#{@valid_token_base64}@plancache.com>", email: "#{@valid_token_base64}@plancache.com", token: @valid_token_base64, host: 'plancache.com', name: "Joe Bloggs" }]
    @invalid_to = [{ full: "Joe Bloggs <111@plancache.com>", email: "111@plancache.com", token: "111", host: 'plancache.com', name: "Joe Bloggs" }]

    @valid_emailmessage = build(:email, to: @valid_to)
    @invalid_emailmessage = build(:email, to: @invalid_to)

    @user = create(:user)
  end
  
  scenario 'it accepts a valid to:field[:token]' do
    page.driver.post(email_processor_path, fake_mandrill_params(true, true))
    expect(Message.count).to eq(1)
  end
  
  scenario 'it rejects an invalid to:field[:token]' do
    page.driver.post(email_processor_path, fake_mandrill_params(false))
    expect(Message.count).to eq(0)
  end
  
  
  def fake_mandrill_params(valid=true, with_attachments=false)
    if with_attachments
      {"mandrill_events"=>"[
        {\"event\":\"inbound\",\"ts\":1423932901,\"msg\":{\"raw_msg\":\"Received: from mail-lb0-f175.google.com (unknown [209.85.217.175])\\n\\tby ip-10-31-192-99 (Postfix) with ESMTPS id 944644001A9\\n\\tfor <test@in.plancache.com>; Sat, 14 Feb 2015 16:55:00 +0000 (UTC)\\nReceived: by mail-lb0-f175.google.com with SMTP id n10so20616636lbv.6\\n        for <test@in.plancache.com>; Sat, 14 Feb 2015 08:54:58 -0800 (PST)\\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed\\/relaxed;\\n        d=gmail.com; s=20120113;\\n        h=mime-version:date:message-id:subject:from:to:content-type;\\n        bh=RmrYassyc7s+7Wgt6Pucq84YEYi7iwk3tqQePwHY3zQ=;\\n        b=JWPkXd9c2fBbstu0Gt+Qjk98m7++IWVFpJgSDsMt7ukzfYIsFT2HuN8GHNAMF3Qidc\\n         ZXCW\\/XQPwkMq3wVUSn7s7cgoQ68Xdr2jTHpPDDRTnBNXdcyDkwMgCb+f3a80JVxOTmkE\\n         VMbLhx80XDicQ9VGWk9C2cDeIbZBdoc+QQ709dQatiJWwby1ybo1\\/2w9uYoOmtBruNzn\\n         rA6g0+tWziDhH+kaL81GCbWtnVCyCPuCNateMHfyjeklz57Hu7oi5WPl+BeB\\/Qch8DXS\\n         c9RAo1MCc7Njr6bpOxMDaU845UvyWRvOrtZ6LkvJGGTiFaegRDD\\/Kyl52DYQUSFoT3Kb\\n         c\\/6A==\\nMIME-Version: 1.0\\nX-Received: by 10.112.41.171 with SMTP id g11mr13211886lbl.107.1423932898705;\\n Sat, 14 Feb 2015 08:54:58 -0800 (PST)\\nReceived: by 10.112.137.232 with HTTP; Sat, 14 Feb 2015 08:54:58 -0800 (PST)\\nDate: Sat, 14 Feb 2015 11:54:58 -0500\\nMessage-ID: <CA+Oq1zQb7aZpUAiyHVGc7YrsOYK4z8yRThFLersv2J3sO-boZQ@mail.gmail.com>\\nSubject: test image\\nFrom: Jason Elbourne <jayelbourne@gmail.com>\\nTo: test@in.plancache.com\\nContent-Type: multipart\\/mixed; boundary=001a11346d9c9ca30d050f0f36c8\\n\\n--001a11346d9c9ca30d050f0f36c8\\nContent-Type: multipart\\/alternative; boundary=001a11346d9c9ca306050f0f36c6\\n\\n--001a11346d9c9ca306050f0f36c6\\nContent-Type: text\\/plain; charset=UTF-8\\n\\ntest image\\n\\n--001a11346d9c9ca306050f0f36c6\\nContent-Type: text\\/html; charset=UTF-8\\n\\n<div dir=\\\"ltr\\\">test image<\\/div>\\n\\n--001a11346d9c9ca306050f0f36c6--\\n--001a11346d9c9ca30d050f0f36c8\\nContent-Type: image\\/png; name=\\\"FFFFFF-0.png\\\"\\nContent-Disposition: attachment; filename=\\\"FFFFFF-0.png\\\"\\nContent-Transfer-Encoding: base64\\nX-Attachment-Id: f_i658vo6k0\\n\\niVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEA\\nAAAASUVORK5CYII=\\n--001a11346d9c9ca30d050f0f36c8--\",\"headers\":{\"Received\":[\"from mail-lb0-f175.google.com (unknown [209.85.217.175]) by ip-10-31-192-99 (Postfix) with ESMTPS id 944644001A9 for <test@in.plancache.com>; Sat, 14 Feb 2015 16:55:00 +0000 (UTC)\",\"by mail-lb0-f175.google.com with SMTP id n10so20616636lbv.6 for <test@in.plancache.com>; Sat, 14 Feb 2015 08:54:58 -0800 (PST)\",\"by 10.112.137.232 with HTTP; Sat, 14 Feb 2015 08:54:58 -0800 (PST)\"],\"Dkim-Signature\":\"v=1; a=rsa-sha256; c=relaxed\\/relaxed; d=gmail.com; s=20120113; h=mime-version:date:message-id:subject:from:to:content-type; bh=RmrYassyc7s+7Wgt6Pucq84YEYi7iwk3tqQePwHY3zQ=; b=JWPkXd9c2fBbstu0Gt+Qjk98m7++IWVFpJgSDsMt7ukzfYIsFT2HuN8GHNAMF3Qidc ZXCW\\/XQPwkMq3wVUSn7s7cgoQ68Xdr2jTHpPDDRTnBNXdcyDkwMgCb+f3a80JVxOTmkE VMbLhx80XDicQ9VGWk9C2cDeIbZBdoc+QQ709dQatiJWwby1ybo1\\/2w9uYoOmtBruNzn rA6g0+tWziDhH+kaL81GCbWtnVCyCPuCNateMHfyjeklz57Hu7oi5WPl+BeB\\/Qch8DXS c9RAo1MCc7Njr6bpOxMDaU845UvyWRvOrtZ6LkvJGGTiFaegRDD\\/Kyl52DYQUSFoT3Kb c\\/6A==\",\"Mime-Version\":\"1.0\",\"X-Received\":\"by 10.112.41.171 with SMTP id g11mr13211886lbl.107.1423932898705; Sat, 14 Feb 2015 08:54:58 -0800 (PST)\",\"Date\":\"Sat, 14 Feb 2015 11:54:58 -0500\",\"Message-Id\":\"<CA+Oq1zQb7aZpUAiyHVGc7YrsOYK4z8yRThFLersv2J3sO-boZQ@mail.gmail.com>\",\"Subject\":\"test image\",\"From\":\"Jason Elbourne <jayelbourne@gmail.com>\",\"To\":\"test@in.plancache.com\",\"Content-Type\":\"multipart\\/mixed; boundary=001a11346d9c9ca30d050f0f36c8\"},\"text\":\"test image\\n\\n\",\"text_flowed\":false,\"html\":\"<div dir=\\\"ltr\\\">test image<\\/div>\\n\\n\",\"attachments\":{\"FFFFFF-0.png\":{\"name\":\"FFFFFF-0.png\",\"type\":\"image\\/png\",\"content\":\"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP6zwAAAgcBApocMXEAAAAASUVORK5CYII=\",\"base64\":true}},\"from_email\":\"jayelbourne@gmail.com\",\"from_name\":\"Jason Elbourne\",\"to\":[[\"test@in.plancache.com\",null]],\"subject\":\"test image\",\"spf\":{\"result\":\"pass\",\"detail\":\"sender SPF authorized\"},\"spam_report\":{\"score\":0.5,\"matched_rules\":[{\"name\":\"FREEMAIL_FROM\",\"score\":0,\"description\":\"Sender email is commonly abused enduser mail provider\"},{\"name\":null,\"score\":0,\"description\":null},{\"name\":\"RCVD_IN_DNSWL_LOW\",\"score\":-0.7,\"description\":\"RBL: Sender listed at http:\\/\\/www.dnswl.org\\/, low\"},{\"name\":\"listed\",\"score\":0,\"description\":\"in list.dnswl.org]\"},{\"name\":\"HTML_MESSAGE\",\"score\":0,\"description\":\"BODY: HTML included in message\"},{\"name\":\"DKIM_VALID_AU\",\"score\":-0.1,\"description\":\"Message has a valid DKIM or DK signature from author's\"},{\"name\":\"DKIM_SIGNED\",\"score\":0.1,\"description\":\"Message has a DKIM or DK signature, not necessarily valid\"},{\"name\":\"DKIM_VALID\",\"score\":-0.1,\"description\":\"Message has at least one valid DKIM or DK signature\"},{\"name\":\"RDNS_NONE\",\"score\":1.3,\"description\":\"Delivered to internal network by a host with no rDNS\"}]},\"dkim\":{\"signed\":true,\"valid\":true},\"email\":\"test@in.plancache.com\",\"tags\":[],\"sender\":null,\"template\":null}}]"
      }
    else
      if valid
        {"mandrill_events"=>"[
          {\"event\":\"inbound\",\"msg\":{\"dkim\":{\"signed\":true,\"valid\":true},\"email\":\"7Kck6KLj@plancache.com\",\"from_email\":\"example.sender@mandrillapp.com\",\"headers\":{\"Content-Type\":\"multipart\\/alternative; boundary=\\\"_av-7r7zDhHxVEAo2yMWasfuFw\\\"\",\"Date\":\"Fri, 10 May 2013 19:28:20 +0000\",\"Dkim-Signature\":[\"v=1; a=rsa-sha1; c=relaxed\\/relaxed; s=mandrill; d=mail115.us4.mandrillapp.com; h=From:Sender:Subject:List-Unsubscribe:To:Message-Id:Date:MIME-Version:Content-Type; i=example.sender@mail115.us4.mandrillapp.com; bh=d60x72jf42gLILD7IiqBL0OBb40=; b=iJd7eBugdIjzqW84UZ2xynlg1SojANJR6xfz0JDD44h78EpbqJiYVcMIfRG7mkrn741Bd5YaMR6p 9j41OA9A5am+8BE1Ng2kLRGwou5hRInn+xXBAQm2NUt5FkoXSpvm4gC4gQSOxPbQcuzlLha9JqxJ 8ZZ89\\/20txUrRq9cYxk=\",\"v=1; a=rsa-sha256; c=relaxed\\/relaxed; d=c.mandrillapp.com; i=@c.mandrillapp.com; q=dns\\/txt; s=mandrill; t=1368214100; h=From : Sender : Subject : List-Unsubscribe : To : Message-Id : Date : MIME-Version : Content-Type : From : Subject : Date : X-Mandrill-User : List-Unsubscribe; bh=y5Vz+RDcKZmWzRc9s0xUJR6k4APvBNktBqy1EhSWM8o=; b=PLAUIuw8zk8kG5tPkmcnSanElxt6I5lp5t32nSvzVQE7R8u0AmIEjeIDZEt31+Q9PWt+nY sHHRsXUQ9SZpndT9Bk++\\/SmyA2ntU\\/2AKuqDpPkMZiTqxmGF80Wz4JJgx2aCEB1LeLVmFFwB 5Nr\\/LBSlsBlRcjT9QiWw0\\/iRvCn74=\"],\"Domainkey-Signature\":\"a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=mail115.us4.mandrillapp.com; b=X6qudHd4oOJvVQZcoAEUCJgB875SwzEO5UKf6NvpfqyCVjdaO79WdDulLlfNVELeuoK2m6alt2yw 5Qhp4TW5NegyFf6Ogr\\/Hy0Lt411r\\/0lRf0nyaVkqMM\\/9g13B6D9CS092v70wshX8+qdyxK8fADw8 kEelbCK2cEl0AGIeAeo=;\",\"From\":\"<example.sender@mandrillapp.com>\",\"List-Unsubscribe\":\"<mailto:unsubscribe-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mailin1.us2.mcsv.net?subject=unsub>\",\"Message-Id\":\"<999.20130510192820.aaaaaaaaaaaaaa.aaaaaaaa@mail115.us4.mandrillapp.com>\",\"Mime-Version\":\"1.0\",\"Received\":[\"from mail115.us4.mandrillapp.com (mail115.us4.mandrillapp.com [205.201.136.115]) by mail.example.com (Postfix) with ESMTP id AAAAAAAAAAA for <7Kck6KLj@plancache.com>; Fri, 10 May 2013 19:28:21 +0000 (UTC)\",\"from localhost (127.0.0.1) by mail115.us4.mandrillapp.com id hhl55a14i282 for <7Kck6KLj@plancache.com>; Fri, 10 May 2013 19:28:20 +0000 (envelope-from <bounce-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mail115.us4.mandrillapp.com>)\"],\"Sender\":\"<example.sender@mail115.us4.mandrillapp.com>\",\"Subject\":\"This is an example webhook message\",\"To\":\"<7Kck6KLj@plancache.com>\",\"X-Report-Abuse\":\"Please forward a copy of this message, including all headers, to abuse@mandrill.com\"},\"html\":\"<p>This is an example inbound message.<\\/p><img src=\\\"http:\\/\\/mandrillapp.com\\/track\\/open.php?u=999&id=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&tags=_all,_sendexample.sender@mandrillapp.com\\\" height=\\\"1\\\" width=\\\"1\\\">\\n\",\"raw_msg\":\"Received: from mail115.us4.mandrillapp.com (mail115.us4.mandrillapp.com [205.201.136.115])\\n\\tby mail.example.com (Postfix) with ESMTP id AAAAAAAAAAA\\n\\tfor <7Kck6KLj@plancache.com>; Fri, 10 May 2013 19:28:20 +0000 (UTC)\\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed\\/relaxed; s=mandrill; d=mail115.us4.mandrillapp.com;\\n h=From:Sender:Subject:List-Unsubscribe:To:Message-Id:Date:MIME-Version:Content-Type; i=example.sender@mail115.us4.mandrillapp.com;\\n bh=d60x72jf42gLILD7IiqBL0OBb40=;\\n b=iJd7eBugdIjzqW84UZ2xynlg1SojANJR6xfz0JDD44h78EpbqJiYVcMIfRG7mkrn741Bd5YaMR6p\\n 9j41OA9A5am+8BE1Ng2kLRGwou5hRInn+xXBAQm2NUt5FkoXSpvm4gC4gQSOxPbQcuzlLha9JqxJ\\n 8ZZ89\\/20txUrRq9cYxk=\\nDomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=mail115.us4.mandrillapp.com;\\n b=X6qudHd4oOJvVQZcoAEUCJgB875SwzEO5UKf6NvpfqyCVjdaO79WdDulLlfNVELeuoK2m6alt2yw\\n 5Qhp4TW5NegyFf6Ogr\\/Hy0Lt411r\\/0lRf0nyaVkqMM\\/9g13B6D9CS092v70wshX8+qdyxK8fADw8\\n kEelbCK2cEl0AGIeAeo=;\\nReceived: from localhost (127.0.0.1) by mail115.us4.mandrillapp.com id hhl55a14i282 for <7Kck6KLj@plancache.com>; Fri, 10 May 2013 19:28:20 +0000 (envelope-from <bounce-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mail115.us4.mandrillapp.com>)\\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed\\/relaxed; d=c.mandrillapp.com; \\n i=@c.mandrillapp.com; q=dns\\/txt; s=mandrill; t=1368214100; h=From : \\n Sender : Subject : List-Unsubscribe : To : Message-Id : Date : \\n MIME-Version : Content-Type : From : Subject : Date : X-Mandrill-User : \\n List-Unsubscribe; bh=y5Vz+RDcKZmWzRc9s0xUJR6k4APvBNktBqy1EhSWM8o=; \\n b=PLAUIuw8zk8kG5tPkmcnSanElxt6I5lp5t32nSvzVQE7R8u0AmIEjeIDZEt31+Q9PWt+nY\\n sHHRsXUQ9SZpndT9Bk++\\/SmyA2ntU\\/2AKuqDpPkMZiTqxmGF80Wz4JJgx2aCEB1LeLVmFFwB\\n 5Nr\\/LBSlsBlRcjT9QiWw0\\/iRvCn74=\\nFrom: <example.sender@mandrillapp.com>\\nSender: <example.sender@mail115.us4.mandrillapp.com>\\nSubject: This is an example webhook message\\nList-Unsubscribe: <mailto:unsubscribe-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mailin1.us2.mcsv.net?subject=unsub>\\nTo: <7Kck6KLj@plancache.com>\\nX-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com\\nX-Mandrill-User: md_999\\nMessage-Id: <999.20130510192820.aaaaaaaaaaaaaa.aaaaaaaa@mail115.us4.mandrillapp.com>\\nDate: Fri, 10 May 2013 19:28:20 +0000\\nMIME-Version: 1.0\\nContent-Type: multipart\\/alternative; boundary=\\\"_av-7r7zDhHxVEAo2yMWasfuFw\\\"\\n\\n--_av-7r7zDhHxVEAo2yMWasfuFw\\nContent-Type: text\\/plain; charset=utf-8\\nContent-Transfer-Encoding: 7bit\\n\\nThis is an example inbound message.\\n--_av-7r7zDhHxVEAo2yMWasfuFw\\nContent-Type: text\\/html; charset=utf-8\\nContent-Transfer-Encoding: 7bit\\n\\n<p>This is an example inbound message.<\\/p><img src=\\\"http:\\/\\/mandrillapp.com\\/track\\/open.php?u=999&id=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&tags=_all,_sendexample.sender@mandrillapp.com\\\" height=\\\"1\\\" width=\\\"1\\\">\\n--_av-7r7zDhHxVEAo2yMWasfuFw--\",\"sender\":null,\"spam_report\":{\"matched_rules\":[{\"description\":\"RBL: Sender listed at http:\\/\\/www.dnswl.org\\/, no\",\"name\":\"RCVD_IN_DNSWL_NONE\",\"score\":0},{\"description\":null,\"name\":null,\"score\":0},{\"description\":\"in iadb.isipp.com]\",\"name\":\"listed\",\"score\":0},{\"description\":\"RBL: Participates in the IADB system\",\"name\":\"RCVD_IN_IADB_LISTED\",\"score\":-0.4},{\"description\":\"RBL: ISIPP IADB lists as vouched-for sender\",\"name\":\"RCVD_IN_IADB_VOUCHED\",\"score\":-2.2},{\"description\":\"RBL: IADB: Sender publishes SPF record\",\"name\":\"RCVD_IN_IADB_SPF\",\"score\":0},{\"description\":\"RBL: IADB: Sender publishes Sender ID record\",\"name\":\"RCVD_IN_IADB_SENDERID\",\"score\":0},{\"description\":\"RBL: IADB: Sender publishes Domain Keys record\",\"name\":\"RCVD_IN_IADB_DK\",\"score\":-0.2},{\"description\":\"RBL: IADB: Sender has reverse DNS record\",\"name\":\"RCVD_IN_IADB_RDNS\",\"score\":-0.2},{\"description\":\"SPF: HELO matches SPF record\",\"name\":\"SPF_HELO_PASS\",\"score\":0},{\"description\":\"BODY: HTML included in message\",\"name\":\"HTML_MESSAGE\",\"score\":0},{\"description\":\"BODY: HTML: images with 0-400 bytes of words\",\"name\":\"HTML_IMAGE_ONLY_04\",\"score\":0.3},{\"description\":\"Message has a DKIM or DK signature, not necessarily valid\",\"name\":\"DKIM_SIGNED\",\"score\":0.1},{\"description\":\"Message has at least one valid DKIM or DK signature\",\"name\":\"DKIM_VALID\",\"score\":-0.1}],\"score\":-2.6},\"spf\":{\"detail\":\"sender SPF authorized\",\"result\":\"pass\"},\"subject\":\"This is an example webhook message\",\"tags\":[],\"template\":null,\"text\":\"This is an example inbound message.\\n\",\"text_flowed\":false,\"to\":[[\"7Kck6KLj@plancache.com\",null]]},\"ts\":1368214102}
          ]"
        }
      else
        {"mandrill_events"=>"[
          {\"event\":\"inbound\",\"msg\":{\"dkim\":{\"signed\":true,\"valid\":true},\"email\":\"1234@plancache.com\",\"from_email\":\"example.sender@mandrillapp.com\",\"headers\":{\"Content-Type\":\"multipart\\/alternative; boundary=\\\"_av-7r7zDhHxVEAo2yMWasfuFw\\\"\",\"Date\":\"Fri, 10 May 2013 19:28:20 +0000\",\"Dkim-Signature\":[\"v=1; a=rsa-sha1; c=relaxed\\/relaxed; s=mandrill; d=mail115.us4.mandrillapp.com; h=From:Sender:Subject:List-Unsubscribe:To:Message-Id:Date:MIME-Version:Content-Type; i=example.sender@mail115.us4.mandrillapp.com; bh=d60x72jf42gLILD7IiqBL0OBb40=; b=iJd7eBugdIjzqW84UZ2xynlg1SojANJR6xfz0JDD44h78EpbqJiYVcMIfRG7mkrn741Bd5YaMR6p 9j41OA9A5am+8BE1Ng2kLRGwou5hRInn+xXBAQm2NUt5FkoXSpvm4gC4gQSOxPbQcuzlLha9JqxJ 8ZZ89\\/20txUrRq9cYxk=\",\"v=1; a=rsa-sha256; c=relaxed\\/relaxed; d=c.mandrillapp.com; i=@c.mandrillapp.com; q=dns\\/txt; s=mandrill; t=1368214100; h=From : Sender : Subject : List-Unsubscribe : To : Message-Id : Date : MIME-Version : Content-Type : From : Subject : Date : X-Mandrill-User : List-Unsubscribe; bh=y5Vz+RDcKZmWzRc9s0xUJR6k4APvBNktBqy1EhSWM8o=; b=PLAUIuw8zk8kG5tPkmcnSanElxt6I5lp5t32nSvzVQE7R8u0AmIEjeIDZEt31+Q9PWt+nY sHHRsXUQ9SZpndT9Bk++\\/SmyA2ntU\\/2AKuqDpPkMZiTqxmGF80Wz4JJgx2aCEB1LeLVmFFwB 5Nr\\/LBSlsBlRcjT9QiWw0\\/iRvCn74=\"],\"Domainkey-Signature\":\"a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=mail115.us4.mandrillapp.com; b=X6qudHd4oOJvVQZcoAEUCJgB875SwzEO5UKf6NvpfqyCVjdaO79WdDulLlfNVELeuoK2m6alt2yw 5Qhp4TW5NegyFf6Ogr\\/Hy0Lt411r\\/0lRf0nyaVkqMM\\/9g13B6D9CS092v70wshX8+qdyxK8fADw8 kEelbCK2cEl0AGIeAeo=;\",\"From\":\"<example.sender@mandrillapp.com>\",\"List-Unsubscribe\":\"<mailto:unsubscribe-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mailin1.us2.mcsv.net?subject=unsub>\",\"Message-Id\":\"<999.20130510192820.aaaaaaaaaaaaaa.aaaaaaaa@mail115.us4.mandrillapp.com>\",\"Mime-Version\":\"1.0\",\"Received\":[\"from mail115.us4.mandrillapp.com (mail115.us4.mandrillapp.com [205.201.136.115]) by mail.example.com (Postfix) with ESMTP id AAAAAAAAAAA for <1234@plancache.com>; Fri, 10 May 2013 19:28:21 +0000 (UTC)\",\"from localhost (127.0.0.1) by mail115.us4.mandrillapp.com id hhl55a14i282 for <1234@plancache.com>; Fri, 10 May 2013 19:28:20 +0000 (envelope-from <bounce-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mail115.us4.mandrillapp.com>)\"],\"Sender\":\"<example.sender@mail115.us4.mandrillapp.com>\",\"Subject\":\"This is an example webhook message\",\"To\":\"<1234@plancache.com>\",\"X-Report-Abuse\":\"Please forward a copy of this message, including all headers, to abuse@mandrill.com\"},\"html\":\"<p>This is an example inbound message.<\\/p><img src=\\\"http:\\/\\/mandrillapp.com\\/track\\/open.php?u=999&id=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&tags=_all,_sendexample.sender@mandrillapp.com\\\" height=\\\"1\\\" width=\\\"1\\\">\\n\",\"raw_msg\":\"Received: from mail115.us4.mandrillapp.com (mail115.us4.mandrillapp.com [205.201.136.115])\\n\\tby mail.example.com (Postfix) with ESMTP id AAAAAAAAAAA\\n\\tfor <1234@plancache.com>; Fri, 10 May 2013 19:28:20 +0000 (UTC)\\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed\\/relaxed; s=mandrill; d=mail115.us4.mandrillapp.com;\\n h=From:Sender:Subject:List-Unsubscribe:To:Message-Id:Date:MIME-Version:Content-Type; i=example.sender@mail115.us4.mandrillapp.com;\\n bh=d60x72jf42gLILD7IiqBL0OBb40=;\\n b=iJd7eBugdIjzqW84UZ2xynlg1SojANJR6xfz0JDD44h78EpbqJiYVcMIfRG7mkrn741Bd5YaMR6p\\n 9j41OA9A5am+8BE1Ng2kLRGwou5hRInn+xXBAQm2NUt5FkoXSpvm4gC4gQSOxPbQcuzlLha9JqxJ\\n 8ZZ89\\/20txUrRq9cYxk=\\nDomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=mail115.us4.mandrillapp.com;\\n b=X6qudHd4oOJvVQZcoAEUCJgB875SwzEO5UKf6NvpfqyCVjdaO79WdDulLlfNVELeuoK2m6alt2yw\\n 5Qhp4TW5NegyFf6Ogr\\/Hy0Lt411r\\/0lRf0nyaVkqMM\\/9g13B6D9CS092v70wshX8+qdyxK8fADw8\\n kEelbCK2cEl0AGIeAeo=;\\nReceived: from localhost (127.0.0.1) by mail115.us4.mandrillapp.com id hhl55a14i282 for <1234@plancache.com>; Fri, 10 May 2013 19:28:20 +0000 (envelope-from <bounce-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mail115.us4.mandrillapp.com>)\\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed\\/relaxed; d=c.mandrillapp.com; \\n i=@c.mandrillapp.com; q=dns\\/txt; s=mandrill; t=1368214100; h=From : \\n Sender : Subject : List-Unsubscribe : To : Message-Id : Date : \\n MIME-Version : Content-Type : From : Subject : Date : X-Mandrill-User : \\n List-Unsubscribe; bh=y5Vz+RDcKZmWzRc9s0xUJR6k4APvBNktBqy1EhSWM8o=; \\n b=PLAUIuw8zk8kG5tPkmcnSanElxt6I5lp5t32nSvzVQE7R8u0AmIEjeIDZEt31+Q9PWt+nY\\n sHHRsXUQ9SZpndT9Bk++\\/SmyA2ntU\\/2AKuqDpPkMZiTqxmGF80Wz4JJgx2aCEB1LeLVmFFwB\\n 5Nr\\/LBSlsBlRcjT9QiWw0\\/iRvCn74=\\nFrom: <example.sender@mandrillapp.com>\\nSender: <example.sender@mail115.us4.mandrillapp.com>\\nSubject: This is an example webhook message\\nList-Unsubscribe: <mailto:unsubscribe-md_999.aaaaaaaa.v1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@mailin1.us2.mcsv.net?subject=unsub>\\nTo: <1234@plancache.com>\\nX-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com\\nX-Mandrill-User: md_999\\nMessage-Id: <999.20130510192820.aaaaaaaaaaaaaa.aaaaaaaa@mail115.us4.mandrillapp.com>\\nDate: Fri, 10 May 2013 19:28:20 +0000\\nMIME-Version: 1.0\\nContent-Type: multipart\\/alternative; boundary=\\\"_av-7r7zDhHxVEAo2yMWasfuFw\\\"\\n\\n--_av-7r7zDhHxVEAo2yMWasfuFw\\nContent-Type: text\\/plain; charset=utf-8\\nContent-Transfer-Encoding: 7bit\\n\\nThis is an example inbound message.\\n--_av-7r7zDhHxVEAo2yMWasfuFw\\nContent-Type: text\\/html; charset=utf-8\\nContent-Transfer-Encoding: 7bit\\n\\n<p>This is an example inbound message.<\\/p><img src=\\\"http:\\/\\/mandrillapp.com\\/track\\/open.php?u=999&id=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&tags=_all,_sendexample.sender@mandrillapp.com\\\" height=\\\"1\\\" width=\\\"1\\\">\\n--_av-7r7zDhHxVEAo2yMWasfuFw--\",\"sender\":null,\"spam_report\":{\"matched_rules\":[{\"description\":\"RBL: Sender listed at http:\\/\\/www.dnswl.org\\/, no\",\"name\":\"RCVD_IN_DNSWL_NONE\",\"score\":0},{\"description\":null,\"name\":null,\"score\":0},{\"description\":\"in iadb.isipp.com]\",\"name\":\"listed\",\"score\":0},{\"description\":\"RBL: Participates in the IADB system\",\"name\":\"RCVD_IN_IADB_LISTED\",\"score\":-0.4},{\"description\":\"RBL: ISIPP IADB lists as vouched-for sender\",\"name\":\"RCVD_IN_IADB_VOUCHED\",\"score\":-2.2},{\"description\":\"RBL: IADB: Sender publishes SPF record\",\"name\":\"RCVD_IN_IADB_SPF\",\"score\":0},{\"description\":\"RBL: IADB: Sender publishes Sender ID record\",\"name\":\"RCVD_IN_IADB_SENDERID\",\"score\":0},{\"description\":\"RBL: IADB: Sender publishes Domain Keys record\",\"name\":\"RCVD_IN_IADB_DK\",\"score\":-0.2},{\"description\":\"RBL: IADB: Sender has reverse DNS record\",\"name\":\"RCVD_IN_IADB_RDNS\",\"score\":-0.2},{\"description\":\"SPF: HELO matches SPF record\",\"name\":\"SPF_HELO_PASS\",\"score\":0},{\"description\":\"BODY: HTML included in message\",\"name\":\"HTML_MESSAGE\",\"score\":0},{\"description\":\"BODY: HTML: images with 0-400 bytes of words\",\"name\":\"HTML_IMAGE_ONLY_04\",\"score\":0.3},{\"description\":\"Message has a DKIM or DK signature, not necessarily valid\",\"name\":\"DKIM_SIGNED\",\"score\":0.1},{\"description\":\"Message has at least one valid DKIM or DK signature\",\"name\":\"DKIM_VALID\",\"score\":-0.1}],\"score\":-2.6},\"spf\":{\"detail\":\"sender SPF authorized\",\"result\":\"pass\"},\"subject\":\"This is an example webhook message\",\"tags\":[],\"template\":null,\"text\":\"This is an example inbound message.\\n\",\"text_flowed\":false,\"to\":[[\"1234@plancache.com\",null]]},\"ts\":1368214102}
          ]"
        }
      end
    end

  end
  
  # scenario 'it rejects an invalid to:field[:token]' do
  #   email = {subject: 'email subject', body: 'Hello!', email:"111@plancache.com"}
  #   page.driver.post email_processor_path, email
  #   expect(Message.count).to eq(0)
  # end
  
  # scenario 'it creates a branch for the email subject' do
  #   message = @valid_emailmessage
  #   page.driver.post email_processor_path, message.marshal_dump
  #
  #   expect(Branch.count).to eq(1)
  #
  #   branch = Branch.last
  #   expect(branch.subject).to eq(message.subject)
  # end
  #
  # scenario 'it creates a message for the email body' do
  #   message = @valid_emailmessage
  #   page.driver.post email_processor_path, message.marshal_dump
  #
  #   expect(Message.count).to eq(1)
  #
  #   message = Message.last
  #   expect(message.body).to eq(message.body)
  # end

end